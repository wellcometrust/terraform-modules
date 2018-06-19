locals {
  mount_points = "${jsonencode(var.mount_points)}"
}

data "template_file" "definition" {
  count = "${var.task_definition_template_path == "" ? 1 : 0}"

  template = "${file("${path.module}/templates/default.json.template")}"

  vars {
    log_group_region = "${var.aws_region}"
    log_group_name   = "${var.log_group_name}"
    log_group_prefix = "${var.log_group_prefix}"

    container_image = "${var.container_image}"
    container_name  = "${var.container_name}"
    container_port  = "${var.container_port}"

    environment_vars = "${var.env_var_string}"

    cpu    = "${var.cpu}"
    memory = "${var.memory}"

    mount_points = "${local.mount_points}"
  }
}

data "template_file" "custom_definition" {
  count = "${var.task_definition_template_path == "" ? 0 : 1}"

  template = "${file("${var.task_definition_template_path}")}"

  vars {
    log_group_region = "${var.aws_region}"
    log_group_name   = "${var.log_group_name}"
    log_group_prefix = "${var.log_group_prefix}"

    container_image = "${var.container_image}"
    container_name  = "${var.container_name}"
    container_port  = "${var.container_port}"

    environment_vars = "${var.env_var_string}"

    cpu    = "${var.cpu}"
    memory = "${var.memory}"

    mount_points = "${local.mount_points}"
  }
}
