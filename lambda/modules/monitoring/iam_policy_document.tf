data "aws_iam_policy_document" "cloudwatch_logs" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "${aws_cloudwatch_log_group.cloudwatch_log_group.arn}",
    ]
  }
}

data "aws_iam_policy_document" "lambda_dlq" {
  statement {
    actions = [
      "sqs:SendMessage",
    ]

    resources = [
      "${aws_sqs_queue.lambda_dlq.arn}",
    ]
  }
}
