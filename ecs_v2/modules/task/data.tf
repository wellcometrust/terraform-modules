data "template_file" "definition" {
  count = "${var.task_definition_template_path == "" ? 1 : 0}"

  template = "${file("${path.module}/templates/default.json.template")}"

  vars {
    log_group_region = "${var.aws_region}"
    log_group_name   = "${aws_cloudwatch_log_group.task.name}"
    log_group_prefix = "${var.log_group_prefix}"

    container_image = "${var.container_image}"
    container_name  = "${local.container_name}"
    container_port  = "${var.container_port}"

    environment_vars = "${local.env_var_string}"

    cpu    = "${var.cpu}"
    memory = "${var.memory}"
  }
}

data "template_file" "custom_definition" {
  count = "${var.task_definition_template_path == "" ? 0 : 1}"

  template = "${file("${var.task_definition_template_path}")}"

  vars {
    log_group_region = "${var.aws_region}"
    log_group_name   = "${aws_cloudwatch_log_group.task.name}"
    log_group_prefix = "${var.log_group_prefix}"

    app_uri          = "${var.container_image}"
    environment_vars = "${local.env_var_string}"

    cpu    = "${var.cpu}"
    memory = "${var.memory}"
  }
}

data "aws_iam_role" "task_role" {
  name = "${module.iam_role.name}"
}

# The AWS task definition format requires that you pass environment variables
# as a list of objects in the form:
#
#     [
#       {
#         "name": "IP_ADDRESS",
#         "value": "192.0.2.6"
#       },
#       ...
#     ]
#
# This is very tedious and boring.  Asking downstream users to declare their
# config variables as name/value pairs exposes this abstraction, so we have
# to push the limits of Terraform's interpolation syntax to get this working.
#
# In a proper language, you can map over a list; something like:
#
#     >>> vars = {'IP_ADDRESS': '192.0.2.6', 'HOST': 'localhost'}
#     >>> def to_name_val_pair(var_pair):
#     ...     name, value = var_pair
#     ...     return {'name': name, 'value': value}
#     ...
#     >>> map(to_name_val_pair, vars.items())
#     [{'name': 'HOST', 'value': 'localhost'},
#      {'name': 'IP_ADDRESS', 'value': '192.0.2.6'}]
#
# and then convert the result to JSON.  Unfortunately Terraform doesn't
# (as far as I know?) give you a way to map over lists or maps that way, so
# we get slightly creative.
#
# The template returns a single name-value pair, as a JSON dict:
#
#     {"name": "IP_ADDRESS", "value": "192.0.2.6"}
#
# Then we iterate that template over `local.env_vars`, which is a map
# containing all our environment variables as key-value pairs, i.e.
#
#     env_vars = {
#       IP_ADDRESS = "192.0.2.6"
#       HOST       = "localhost"
#     }
#
# rendering each of them as JSON dict.  Then we call join(", ", ...) on the
# output to put them all in a list, and wrap that in square brackets.
#
# Based on "Using templates with count" in the Terraform interpolation syntax
# docs: https://www.terraform.io/docs/configuration/interpolation.html

data "template_file" "name_val_pair" {
  count    = "${var.config_vars_length + length(var.service_vars)}"
  template = "{\"name\": $${jsonencode(key)}, \"value\": $${jsonencode(value)}}"

  vars {
    key   = "${element(keys(local.env_vars), count.index)}"
    value = "${element(values(local.env_vars), count.index)}"
  }
}

locals {
  env_vars       = "${merge(var.service_vars, var.config_vars)}"
  env_var_string = "[${join(", ", "${data.template_file.name_val_pair.*.rendered}")}]"
}
