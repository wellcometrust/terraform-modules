data "aws_ecs_cluster" "cluster" {
  cluster_name = "${var.cluster_name}"
}

module "service" {
  source = "../../../modules/service/prebuilt/load_balanced"

  service_name = "${var.service_name}"

  task_definition_arn = "${module.task.task_definition_arn}"

  security_group_ids = ["${local.security_group_ids}"]

  container_name = "${module.task.task_name}"
  container_port = "${module.task.task_port}"

  ecs_cluster_id = "${data.aws_ecs_cluster.cluster.id}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.subnets}"

  namespace_id = "${var.namespace_id}"

  launch_type           = "${var.launch_type}"
  target_group_protocol = "${var.target_group_protocol}"

  task_desired_count = "${var.task_desired_count}"

  listener_port = "${var.listener_port}"
  lb_arn        = "${var.lb_arn}"
}

module "task" {
  source = "../../../modules/task/prebuilt/single_container"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  env_vars        = "${var.env_vars}"
  env_vars_length = "${var.env_vars_length}"

  command = "${var.command}"

  aws_region = "${var.aws_region}"
  task_name  = "${var.service_name}"

  container_image = "${var.container_image}"
  container_port  = "${var.container_port}"
}

locals {
  security_group_ids = "${concat(list(var.service_egress_security_group_id), var.security_group_ids)}"
}
