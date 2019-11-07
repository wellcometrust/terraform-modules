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
  // According to hashicorp/terraform#17287 and hashicorp/terraform#14677 length can only
  // be calculated for not computed values. If a map or list contains computed values,
  // the whole map is considered as computed.
  //
  // This means the way we pass environment variables at the moment only works if there
  // are no computed values (i.e. outputs from modules or outputs
  // from terraform resource types).
  //
  // TODO compute count once those issues are closed
  count = "${var.env_vars_length}"

  template = "{\"name\": $${jsonencode(key)}, \"value\": $${jsonencode(value)}}"

  vars = {
    key   = "${element(keys(var.env_vars), count.index)}"
    value = "${element(values(var.env_vars), count.index)}"
  }
}

locals {
  env_var_string = "[${join(", ", "${data.template_file.name_val_pair.*.rendered}")}]"
}
