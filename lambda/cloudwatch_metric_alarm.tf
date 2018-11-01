resource "aws_cloudwatch_metric_alarm" "lambda_alarm" {
  alarm_name          = "lambda-${var.name}-errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"

  dimensions {
    FunctionName = "${var.name}"
  }

  alarm_description = "This metric monitors lambda errors for function: ${var.name}"
  alarm_actions     = ["${var.alarm_topic_arn}"]
}
