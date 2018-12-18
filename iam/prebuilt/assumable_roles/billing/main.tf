module "billing" {
  source     = "../../../modules/assumable_role"
  name       = "billing"
  principals = ["${var.principals}"]
}

resource "aws_iam_role_policy" "admin" {
  role   = "${module.billing.arn}"
  policy = "${data.aws_iam_policy.billing.policy}"
}

data "aws_iam_policy" "billing" {
  arn = "arn:aws:iam::aws:policy/job-function/Billing"
}
