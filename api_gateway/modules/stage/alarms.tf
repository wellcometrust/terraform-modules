resource "aws_cloudwatch_metric_alarm" "5xx_alarm" {
  count = "${var.enable_alarm}"

  alarm_name          = "${var.stage_name}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "5XXError"
  namespace           = "AWS/ApiGateway"
  period              = "60"
  statistic           = "Sum"
  threshold           = "0"

  dimensions {
    ApiName = "${var.api_name}"
    Stage  = "${var.stage_name}"
  }

  alarm_actions     = ["${var.alarm_topic_arn}"]
}