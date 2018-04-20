module "cpureservation_high" {
  source = "./cpureservation_alarm"
  name   = "${var.name}-cpureservation_high"

  cluster_name = "${var.cluster_name}"

  period_in_minutes    = "${var.high_period_in_minutes}"
  threshold = "${var.high_threshold}"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "${var.treat_missing_data_high}"

  target_arn = "${var.scale_up_arn}"
}

module "cpureservation_low" {
  source = "./cpureservation_alarm"
  name   = "${var.name}-cpureservation_low"

  cluster_name = "${var.cluster_name}"

  period_in_minutes    = "${var.low_period_in_minutes}"
  threshold = "${var.low_threshold}"

  comparison_operator = "LessThanThreshold"
  treat_missing_data  = "${var.treat_missing_data_low}"

  target_arn = "${var.scale_down_arn}"
}
