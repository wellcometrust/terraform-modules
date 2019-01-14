module "container_definition" {
  source = "../../modules/container_definition/single_container"

  aws_region = "${var.aws_region}"

  container_image = "${var.container_image}"

  task_name = "${var.task_name}"

  log_group_prefix = "${var.log_group_prefix}"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  mount_points = "${module.task_definition.mount_points}"

  task_port = "${var.container_port}"

  env_vars        = "${var.env_vars}"
  env_vars_length = "${var.env_vars_length}"

  secret_env_vars_length = "${var.secret_env_vars_length}"
  secret_env_vars        = "${var.secret_env_vars}"
}

module "task_definition" {
  source    = "../../modules/task_definition/ebs+efs"
  task_name = "${var.task_name}"

  task_definition_rendered = "${module.container_definition.rendered}"

  efs_container_path = "${var.efs_container_path}"
  efs_host_path      = "${var.efs_host_path}"

  ebs_container_path = "${var.ebs_container_path}"
  ebs_host_path      = "${var.ebs_host_path}"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"
}
