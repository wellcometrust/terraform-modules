module "container_definition" {
  source = "../../modules/container_definition/single_container"

  aws_region = "${var.aws_region}"

  container_image = "${var.container_image}"

  task_name = "${var.task_name}"

  env_vars = "${var.env_vars}"

  log_group_prefix = "${var.log_group_prefix}"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  mount_points = "${module.task_definition.mount_points}"

  task_port = "${var.container_port}"
}

module "task_definition" {
  source    = "../../modules/task_definition/ebs"
  task_name = "${var.task_name}"

  task_definition_rendered = "${module.container_definition.rendered}"

  ebs_container_path = "${var.ebs_container_path}"
  ebs_host_path      = "${var.ebs_host_path}"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"
}
