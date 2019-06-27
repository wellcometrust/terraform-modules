module "read_only" {
  source     = "../../../modules/assumable_role"
  name       = "read_only"
  principals = ["${var.principals}"]
  auth_type  = "${var.auth_type}"
}

resource "aws_iam_role_policy" "read_only" {
  role   = "${module.read_only.name}"
  policy = "${data.aws_iam_policy.read_only.policy}"
}

data "aws_iam_policy" "read_only" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
