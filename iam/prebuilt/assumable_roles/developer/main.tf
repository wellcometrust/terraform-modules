module "developer" {
  source     = "../../../modules/assumable_role"
  name       = "developer"
  principals = ["${var.principals}"]
  auth_type  = "${var.auth_type}"
}

resource "aws_iam_role_policy" "developer_go_hog_wild" {
  role   = "${module.developer.name}"
  policy = "${data.aws_iam_policy_document.go_hog_wild.json}"
}

resource "aws_iam_role_policy" "developer_restrict_destructive_actions" {
  role   = "${module.developer.name}"
  policy = "${data.aws_iam_policy_document.restrict_destructive_actions.json}"
}

resource "aws_iam_role_policy" "developer_iam_user_group_deny" {
  role   = "${module.developer.name}"
  policy = "${data.aws_iam_policy_document.iam_user_group_deny.json}"
}
