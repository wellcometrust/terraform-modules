resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name          = "${var.name}_${var.comparison_operator}"
  comparison_operator = "${var.comparison_operator}"

  evaluation_periods = "${var.period_in_minutes}"

  datapoints_to_alarm = "${var.period_in_minutes}"
  metric_name         = "${var.metric_name}"

  statistic = "${var.statistic}"
  namespace = "${var.namespace}"

  // This is the period over which the statistic is calculated
  // An evaluation over this period produces one datapoint
  // This is NOT the period during which the threshold is evaluated
  period = "${var.period}"

  threshold = "${var.threshold}"

  treat_missing_data = "${var.treat_missing_data}"

  alarm_actions = [
    "${var.target_arn}",
  ]
}
