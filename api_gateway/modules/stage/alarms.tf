locals {
  enable_alarm = "${var.alarm_topic_arn != ""? 1 : 0}"
}

resource "aws_cloudwatch_metric_alarm" "5xx_alarm" {
  count = "${local.enable_alarm}"

  alarm_name          = "${var.api_name}_${var.stage_name}_500_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "5XXError"
  namespace           = "AWS/ApiGateway"
  period              = "60"
  statistic           = "Sum"
  threshold           = "0"

  dimensions {
    ApiName = "${var.api_name}"
    Stage   = "${var.stage_name}"
  }

  alarm_actions = ["${var.alarm_topic_arn}"]
}
