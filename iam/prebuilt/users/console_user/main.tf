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

resource "aws_iam_user_policy" "policy" {
  user   = "${aws_iam_user.user.name}"
  policy = "${data.aws_iam_policy_document.sts.json}"
}

data "aws_iam_policy_document" "sts" {
  "statement" {
    actions   = ["sts:*"]
    resources = ["*"]
  }
}
