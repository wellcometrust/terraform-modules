module "queue_high" {
  source = "./sqs_alarm"
  name = "${var.name}-queue_high"

  queue_name = "${var.queue_name}"

  period = "${var.high_period}"
  threshold = "${var.high_threshold}"

  comparison_operator = "GreaterThanOrEqualToThreshold"

  target_arn = "${var.scale_up_arn}"
}


module "queue_low" {
  source = "./sqs_alarm"
  name = "${var.name}-queue_low"

  queue_name = "${var.queue_name}"

  period = "${var.low_period}"
  threshold = "${var.low_threshold}"

  comparison_operator = "LessThanThreshold"
  treat_missing_data = "breaching"

  target_arn = "${var.scale_down_arn}"
}
