resource "aws_iam_user" "user" {
  name = "${var.username}"
}

resource "aws_iam_user_login_profile" "user" {
  user    = "${aws_iam_user.user.name}"
  pgp_key = "${var.pgp_key}"
}

resource "aws_iam_access_key" "access_key" {
  user    = "${aws_iam_user.user.name}"
  pgp_key = "${var.pgp_key}"
}
