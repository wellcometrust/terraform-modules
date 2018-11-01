resource "aws_iam_role_policy" "cloudwatch_logs" {
  name   = "${aws_iam_role.iam_role.name}_lambda_cloudwatch_logs"
  role   = "${aws_iam_role.iam_role.name}"
  policy = "${data.aws_iam_policy_document.cloudwatch_logs.json}"
}