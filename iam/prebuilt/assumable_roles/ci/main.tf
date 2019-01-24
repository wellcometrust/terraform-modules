module "ci" {
  source     = "../../../modules/assumable_role"
  name       = "ci"
  principals = ["${var.principals}"]
}

resource "aws_iam_role_policy" "ci_publishing" {
  role   = "${module.ci.name}"
  policy = "${data.aws_iam_policy_document.publish_to_aws.json}"
}
