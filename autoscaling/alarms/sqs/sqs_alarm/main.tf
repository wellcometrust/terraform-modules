resource "aws_cloudwatch_metric_alarm" "queue" {
  alarm_name          = "${var.name}-queue_${var.comparison_operator}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"

  dimensions {
    QueueName = "${var.queue_name}"
  }

  statistic = "Average"
  namespace = "AWS/SQS"

  period    = "${var.period}"
  threshold = "${var.threshold}"

  treat_missing_data = "${var.treat_missing_data}"

  alarm_actions = [
    "${var.target_arn}",
  ]
}
