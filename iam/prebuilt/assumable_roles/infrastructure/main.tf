module "infrastructure" {
  source     = "../../../modules/assumable_role"
  name       = "infrastructure"
  principals = ["${var.principals}"]
  auth_type  = "${var.auth_type}"
}

resource "aws_iam_role_policy" "infrastructure_read_only" {
  role   = "${module.infrastructure.name}"
  policy = "${data.aws_iam_policy.read_only.policy}"
}

resource "aws_iam_role_policy" "infrastructure_deny_data" {
  role   = "${module.infrastructure.name}"
  policy = "${data.aws_iam_policy_document.deny_data.json}"
}
