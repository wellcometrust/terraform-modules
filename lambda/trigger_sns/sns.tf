resource "aws_lambda_permission" "allow_sns_trigger" {
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_function_arn}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${var.sns_trigger_arn}"
  depends_on    = ["aws_sns_topic_subscription.topic_lambda"]
}

resource "aws_sns_topic_subscription" "topic_lambda" {
  topic_arn = "${var.sns_trigger_arn}"
  protocol  = "lambda"
  endpoint  = "${var.lambda_function_arn}"
}
