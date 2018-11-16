resource "aws_iam_role_policy" "lambda_dlq" {
  name   = "${var.iam_role_name}_lambda_dlq"
  role   = "${var.iam_role_name}"
  policy = "${data.aws_iam_policy_document.lambda_dlq.json}"
}

resource "aws_iam_role_policy" "cloudwatch_logs" {
  name   = "${var.iam_role_name}_lambda_logs"
  role   = "${var.iam_role_name}"
  policy = "${data.aws_iam_policy_document.cloudwatch_logs.json}"
}
