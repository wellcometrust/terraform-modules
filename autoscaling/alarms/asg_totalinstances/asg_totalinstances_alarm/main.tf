resource "aws_cloudwatch_metric_alarm" "asg_totalinstances" {
  alarm_name          = "${var.name}-asg_totalinstances_${var.comparison_operator}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "1"
  metric_name         = "GroupTotalInstances"

  dimensions {
    AutoScalingGroupName = "${var.asg_name}"
  }

  statistic = "Average"
  namespace = "AWS/AutoScaling"

  period    = "${var.period}"
  threshold = "${var.threshold}"

  treat_missing_data = "${var.treat_missing_data}"

  alarm_actions = [
    "${var.target_arn}",
  ]
}
