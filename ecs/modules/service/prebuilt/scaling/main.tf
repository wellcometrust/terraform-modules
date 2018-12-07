module "service" {
  source = "../default"

  service_name = "${var.service_name}"

  vpc_id              = "${var.vpc_id}"
  task_definition_arn = "${var.task_definition_arn}"

  security_group_ids = ["${var.security_group_ids}"]
  subnets            = ["${var.subnets}"]

  container_port = "${var.container_port}"
  ecs_cluster_id = "${var.cluster_id}"

  task_desired_count = "${var.task_desired_count}"
  namespace_id       = "${var.namespace_id}"

  launch_type = "${var.launch_type}"
}
