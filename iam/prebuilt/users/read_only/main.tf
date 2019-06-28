resource "aws_iam_user" "user" {
  name = "${var.prefix}-read_only"
}

resource "aws_iam_access_key" "access_key" {
  user    = "${aws_iam_user.user.name}"
  pgp_key = "${var.pgp_key}"
}

resource "aws_iam_user_policy_attachment" "role_manager_list_roles_policy_attachement" {
  user       = "${aws_iam_user.user.name}"
  policy_arn = "${data.aws_iam_policy.read_only.arn}"
}

data "aws_iam_policy" "read_only" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}