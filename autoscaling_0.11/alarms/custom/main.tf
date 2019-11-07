module "high" {
  source = "./alarm"
  name   = "${var.name}_high"

  period_in_minutes = "${var.high_period_in_minutes}"
  threshold         = "${var.high_threshold}"

  comparison_operator = "GreaterThanOrEqualToThreshold"

  target_arn  = "${var.scale_up_arn}"
  metric_name = "${var.high_metric_name}"
  statistic   = "Maximum"

  namespace = "${var.namespace}"
}

module "low" {
  source = "./alarm"
  name   = "${var.name}_low"

  period_in_minutes = "${var.low_period_in_minutes}"
  threshold         = "${var.low_threshold}"

  comparison_operator = "LessThanThreshold"

  target_arn  = "${var.scale_down_arn}"
  metric_name = "${var.low_metric_name}"
  statistic   = "Sum"

  namespace = "${var.namespace}"
}
