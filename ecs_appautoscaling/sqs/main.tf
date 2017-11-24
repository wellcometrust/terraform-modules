module "queue_high" {
  source = "./sqs_alarm"
  name = "${var.name}-queue_high"

  queue_name = "${var.queue_name}"

  period = "${var.high_period}"
  threshold = "${var.high_threshold}"

  comparison_operator = "GreaterThanOrEqualToThreshold"

  target_arn = "${module.appautoscaling.scale_up_arn}"
}

module "queue_low" {
  source = "./sqs_alarm"
  name = "${var.name}-queue_low"

  queue_name = "${var.queue_name}"

  period = "${var.low_period}"
  threshold = "${var.low_threshold}"

  comparison_operator = "LessThanThreshold"
  treat_missing_data = "breaching"

  target_arn = "${module.appautoscaling.scale_down_arn}"
}

module "appautoscaling" {
  source = "git::https://github.com/wellcometrust/terraform.git//ecs_appautoscaling/appautoscaling?ref=ecs-sqs-autoscaling-policy"
  name = "${var.name}"

  cluster_name = "${var.cluster_name}"
  service_name = "${var.service_name}"

  scale_up_adjustment = "${var.scale_up_adjustment}"
  scale_down_adjustment = "${var.scale_down_adjustment}"

  min_capacity = "${var.min_capacity}"
  max_capacity = "${var.max_capacity}"
}