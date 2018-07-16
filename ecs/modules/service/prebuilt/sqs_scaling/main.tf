module "appautoscaling" {
  source = "../../../../../autoscaling/app/ecs"
  name   = "${module.service.service_name}"

  cluster_name = "${var.ecs_cluster_name}"
  service_name = "${module.service.service_name}"

  min_capacity = "${var.min_capacity}"
  max_capacity = "${var.max_capacity}"
}

module "sqs_autoscaling_alarms" {
  source = "../../../../../autoscaling/alarms/sqs"
  name   = "${module.service.service_name}"

  queue_name = "${var.source_queue_name}"

  scale_up_arn   = "${module.appautoscaling.scale_up_arn}"
  scale_down_arn = "${module.appautoscaling.scale_down_arn}"

  high_period_in_minutes = "${var.scale_up_period_in_minutes}"
  low_period_in_minutes  = "${var.scale_down_period_in_minutes}"
}

module "service" {
  source = "../default"

  service_name = "${var.service_name}"

  vpc_id              = "${var.vpc_id}"
  task_definition_arn = "${module.task.task_definition_arn}"

  security_group_ids = ["${var.security_group_ids}"]
  subnets            = ["${var.subnets}"]

  container_port = "${var.container_port}"
  ecs_cluster_id = "${var.ecs_cluster_id}"

  task_desired_count = "${var.task_desired_count}"
  namespace_id       = "${var.namespace_id}"

  launch_type = "${var.launch_type}"
}

module "task" {
  source = "../../../task/prebuilt/single_container"

  task_name = "${var.service_name}"

  container_port  = "${var.container_port}"
  container_image = "${var.container_image}"

  memory = "${var.memory}"
  cpu    = "${var.cpu}"

  env_vars        = "${var.env_vars}"
  env_vars_length = "${var.env_vars_length}"

  aws_region = "${var.aws_region}"
}
