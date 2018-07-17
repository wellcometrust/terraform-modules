module "queue_high" {
  source = "./sqs_alarm"
  name   = "${var.name}-queue_high"

  queue_name = "${var.queue_name}"

  period_in_minutes = "${var.high_period_in_minutes}"
  threshold         = "${var.high_threshold}"

  comparison_operator = "GreaterThanOrEqualToThreshold"

  target_arn = "${var.scale_up_arn}"
  metric_name = "ApproximateNumberOfMessagesVisible"
  statistic = "Maximum"
}

module "queue_low" {
  source = "./sqs_alarm"
  name   = "${var.name}-queue_low"

  queue_name = "${var.queue_name}"

  period_in_minutes = "${var.low_period_in_minutes}"
  threshold         = "${var.low_threshold}"

  comparison_operator = "LessThanThreshold"

  target_arn = "${var.scale_down_arn}"
  metric_name = "NumberOfMessagesDeleted"
  statistic = "Sum"
}
