data "aws_ecs_cluster" "cluster" {
  cluster_name = "${var.cluster_name}"
}

module "service" {
  source = "../../../modules/service/prebuilt/load_balanced"

  service_name       = "${var.service_name}"
  task_desired_count = "1"

  task_definition_arn = "${module.task.task_definition_arn}"

  security_group_ids = ["${local.security_group_ids}"]

  container_name = "${local.task_port}"
  container_port = "${local.task_name}"

  ecs_cluster_id = "${data.aws_ecs_cluster.cluster.id}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.subnets}"

  namespace_id = "${var.namespace_id}"

  launch_type           = "${var.launch_type}"
  target_group_protocol = "${var.target_group_protocol}"
}

module "task" {
  source = "../../../modules/task/prebuilt/container_with_sidecar"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  app_cpu    = "${var.app_cpu}"
  app_memory = "${var.app_memory}"

  sidecar_cpu    = "${var.sidecar_cpu}"
  sidecar_memory = "${var.sidecar_memory}"

  app_env_vars        = "${var.app_env_vars}"
  app_env_vars_length = "${var.app_env_vars_length}"

  sidecar_env_vars        = "${var.sidecar_env_vars}"
  sidecar_env_vars_length = "${var.sidecar_env_vars_length}"

  aws_region = "${var.aws_region}"
  task_name  = "${var.service_name}"

  app_container_image = "${var.app_container_image}"
  app_container_port  = "${var.app_container_port}"

  sidecar_container_image = "${var.sidecar_container_image}"
  sidecar_container_port  = "${var.sidecar_container_port}"
}

locals {
  security_group_ids = "${concat(list(var.service_egress_security_group_id), var.security_group_ids)}"
}