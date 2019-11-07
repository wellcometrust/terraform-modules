module "container_definition" {
  source = "../../modules/container_definition/single_container"

  aws_region = "${var.aws_region}"

  container_image = "${var.container_image}"

  task_name = "${var.task_name}"

  log_group_prefix = "${var.log_group_prefix}"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  task_port = "${var.container_port}"

  mount_points = "${var.mount_points}"
  command      = "${var.command}"

  env_vars        = "${var.env_vars}"
  env_vars_length = "${var.env_vars_length}"

  secret_env_vars_length = "${var.secret_env_vars_length}"
  secret_env_vars        = "${var.secret_env_vars}"

  execution_role_name = "${module.task_definition.task_execution_role_name}"
}

module "task_definition" {
  source    = "../../modules/task_definition/default"
  task_name = "${var.task_name}"

  task_definition_rendered = "${module.container_definition.rendered}"

  launch_types = ["${var.launch_types}"]

  cpu    = "${var.cpu}"
  memory = "${var.memory}"
}
