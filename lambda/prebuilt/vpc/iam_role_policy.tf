resource "aws_iam_role_policy" "lambda_vpc_permissions" {
  name   = "${var.name}_lambda_vpc_permissions"
  role   = "${module.iam.role_name}"
  policy = "${data.aws_iam_policy_document.lambda_vpc_permissions.json}"
}
