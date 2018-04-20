resource "aws_cloudwatch_metric_alarm" "ecs_cpureservation_high" {
  alarm_name          = "${var.name}-ecs_cpureservation_${var.comparison_operator}"
  comparison_operator = "${var.comparison_operator}"

  // Actual period during which the threshold is evaluated
  // It depends on the size of the periods over which statistics
  // datapoints are generated.
  // Our datapoints are hardcoded to represent statistics
  // over one minute (see below), so the evaluation period
  // is defined in minutes
  evaluation_periods  = "${var.period_in_minutes}"
  datapoints_to_alarm = "${var.period_in_minutes}"
  metric_name         = "CPUReservation"

  dimensions {
    ClusterName = "${var.cluster_name}"
  }

  statistic = "Average"
  namespace = "AWS/ECS"

  // This is the period over which the statistic is calculated
  // An evaluation over this period produces one datapoint
  // This is NOT the period during which the threshold is evaluated
  period    = "60"
  threshold = "${var.threshold}"

  treat_missing_data = "${var.treat_missing_data}"

  alarm_actions = [
    "${var.target_arn}",
  ]
}
