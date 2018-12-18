resource "aws_iam_user" "user" {
  name = "${var.username}"
}

resource "aws_iam_user_login_profile" "user" {
  user    = "${aws_iam_user.user.name}"
  pgp_key = "keybase:${var.keybase_name}"
}

resource "aws_iam_access_key" "access_key_primary" {
  user    = "${aws_iam_user.user.name}"
  pgp_key = "keybase:${var.keybase_name}"
}

resource "aws_iam_access_key" "access_key_secondary" {
  user    = "${aws_iam_user.user.name}"
  pgp_key = "keybase:${var.keybase_name}"
}

resource "aws_iam_user_policy" "developer_admin" {
  user   = "${aws_iam_user.user.name}"
  policy = "${data.aws_iam_policy_document.dev_user.json}"
}
