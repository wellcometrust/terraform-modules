module "infrastructure" {
  source     = "../../../modules/assumable_role"
  name       = "infrastructure"
  principals = ["${var.principals}"]
}

resource "aws_iam_role_policy" "infrastructure" {
  role   = "${module.infrastructure.arn}"
  policy = "${data.aws_iam_policy.read_only.arn}"
}

resource "aws_iam_role_policy" "dev_go_hog_wild" {
  role   = "${module.infrastructure.arn}"
  policy = "${data.aws_iam_policy_document.deny_data.json}"
}
