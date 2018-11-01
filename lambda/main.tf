locals {
  public_lambda_function_count = "${var.lambda_type == "public" ? 1 : 0}"
  vpc_lambda_function_count    = "${var.lambda_type == "public" ? 0 : 1}"
}

module "public_lambda_function" {
  source = "function/public"
  count  = "${local.public_lambda_function_count}"

  name = "${var.name}"

  module_name = "${var.module_name}"
  description = "${var.description}"

  s3_bucket = "${var.s3_bucket}"
  s3_key    = "${var.s3_key}"

  environment_variables = "${var.environment_variables}"

  memory_size = "${var.memory_size}"
  timeout     = "${var.timeout}"

  iam_role_arn = "${aws_iam_role.iam_role.arn}"

  lambda_dlq_arn = "${aws_sqs_queue.lambda_dlq.arn}"
}

module "vpc_lambda_function" {
  source = "function/vpc"
  count  = "${local.vpc_lambda_function_count}"

  name = "${var.name}"

  module_name = "${var.module_name}"
  description = "${var.description}"

  s3_bucket = "${var.s3_bucket}"
  s3_key    = "${var.s3_key}"

  environment_variables = "${var.environment_variables}"

  memory_size = "${var.memory_size}"
  timeout     = "${var.timeout}"

  iam_role_arn = "${aws_iam_role.iam_role.arn}"

  lambda_dlq_arn = "${aws_sqs_queue.lambda_dlq.arn}"

  # VPC specific
  security_group_ids = "${var.security_group_ids}"
  subnet_ids         = "${var.subnet_ids}"
}
