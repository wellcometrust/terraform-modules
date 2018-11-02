resource "aws_iam_role_policy" "lambda_vpc_permissions" {
  name   = "${var.name}_lambda_vpc_permissions"
  role   = "${data.aws_iam_role.lambda.name}"
  policy = "${data.aws_iam_policy_document.lambda_vpc_permissions.json}"
}

data "aws_iam_role" "lambda" {
  name = "${module.iam.role_name}"
}
