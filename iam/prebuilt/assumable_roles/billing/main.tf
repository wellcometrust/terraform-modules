module "billing" {
  source     = "../../../modules/assumable_role"
  name       = "billing"
  principals = ["${var.principals}"]
  auth_type  = "${var.auth_type}"

}

resource "aws_iam_role_policy" "admin" {
  role   = "${module.billing.name}"
  policy = "${data.aws_iam_policy.billing.policy}"
}

data "aws_iam_policy" "billing" {
  arn = "arn:aws:iam::aws:policy/job-function/Billing"
}
