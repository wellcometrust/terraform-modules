resource "aws_cloudwatch_metric_alarm" "ecs_cpureservation_high" {
  alarm_name          = "${var.name}-ecs_cpureservation_high"
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
