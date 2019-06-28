resource "aws_iam_role_policy" "read_only" {
  role   = "${var.role_name}"
  policy = "${data.aws_iam_policy.read_only.policy}"
}

data "aws_iam_policy" "read_only" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
