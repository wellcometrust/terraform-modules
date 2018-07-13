module "container_definition" {
  source = "../../modules/container_definition/single_container"

  aws_region = "${var.aws_region}"

  container_image = "${var.container_image}"

  task_name = "${var.task_name}"

  env_vars = "${var.env_vars}"

  log_group_prefix = "${var.log_group_prefix}"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  task_port = "${var.container_port}"

  env_vars_length = "${var.env_vars_length}"
}

module "task_definition" {
  source    = "../../modules/task_definition/default"
  task_name = "${var.task_name}"

  task_definition_rendered = "${module.container_definition.rendered}"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"
}
