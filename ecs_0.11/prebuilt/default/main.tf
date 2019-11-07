module "service" {
  source = "../../modules/service/prebuilt/default"

  security_group_ids = ["${var.security_group_ids}"]
  subnets            = ["${var.subnets}"]
  namespace_id       = "${var.namespace_id}"

  task_definition_arn = "${module.task.task_definition_arn}"
  task_desired_count  = "${var.desired_task_count}"
  launch_type         = "${var.launch_type}"

  cluster_id = "${var.cluster_id}"

  service_name = "${var.service_name}"
}

module "task" {
  source = "../../modules/task/prebuilt/single_container"

  task_name = "${var.service_name}"

  container_port  = "${var.container_port}"
  container_image = "${var.container_image}"

  memory = "${var.memory}"
  cpu    = "${var.cpu}"

  env_vars        = "${var.env_vars}"
  env_vars_length = "${var.env_vars_length}"

  secret_env_vars        = "${var.secret_env_vars}"
  secret_env_vars_length = "${var.secret_env_vars_length}"

  aws_region = "${var.aws_region}"

  launch_types = ["${var.launch_type}"]

  command = "${var.command}"
}
