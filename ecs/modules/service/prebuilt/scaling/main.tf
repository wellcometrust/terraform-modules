module "service" {
  source = "ecs"

  service_name = "${var.service_name}"

  task_definition_arn = "${var.task_definition_arn}"

  security_group_ids = ["${var.security_group_ids}"]
  subnets            = ["${var.subnets}"]

  ecs_cluster_id = "${var.cluster_id}"

  task_desired_count = "${var.task_desired_count}"
  namespace_id       = "${var.namespace_id}"

  launch_type = "${var.launch_type}"
}
