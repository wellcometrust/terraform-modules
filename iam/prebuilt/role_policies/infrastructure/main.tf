resource "aws_iam_role_policy" "infrastructure_read_only" {
  role   = "${var.role_name}"
  policy = "${data.aws_iam_policy.read_only.policy}"
}

resource "aws_iam_role_policy" "infrastructure_deny_data" {
  role   = "${var.role_name}"
  policy = "${data.aws_iam_policy_document.deny_data.json}"
}
