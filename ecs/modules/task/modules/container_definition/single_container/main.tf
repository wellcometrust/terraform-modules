locals {
  mount_points   = "${jsonencode(var.mount_points)}"
  log_group_name = "${var.task_name}"
  container_name = "app"
}

data "template_file" "definition" {
  template = "${file("${path.module}/task_definition.json.template")}"

  vars {
    log_group_region = "${var.aws_region}"
    log_group_name   = "${module.log_group.name}"
    log_group_prefix = "${var.log_group_prefix}"

    container_image = "${var.container_image}"
    container_name  = "${local.container_name}"
    container_port  = "${var.task_port}"

    environment_vars = "${module.env_vars.env_vars_string}"

    cpu    = "${var.cpu}"
    memory = "${var.memory}"

    mount_points = "${local.mount_points}"
  }
}

module "log_group" {
  source = "../../log_group"

  task_name = "${var.task_name}"
}

module "env_vars" {
  source = "../../env_vars"

  env_vars = "${var.env_vars}"
}