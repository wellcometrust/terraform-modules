# There can only be one terraform_root user per account
resource "aws_iam_user" "terraform_root" {
  name = "terraform_root"
}

resource "aws_iam_access_key" "access_key" {
  user    = "${aws_iam_user.terraform_root.name}"
  pgp_key = "${var.pgp_key}"
}

resource "aws_iam_user_policy" "terraform_root" {
  user   = "${aws_iam_user.terraform_root.name}"
  policy = "${data.aws_iam_policy.admin.policy}"
}

data "aws_iam_policy" "admin" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
