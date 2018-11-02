data "aws_s3_bucket_object" "package" {
  bucket = "${var.s3_bucket}"
  key    = "${var.s3_key}"
}

module "iam" {
  source = "../../modules/iam"
  name   = "${var.name}"
}

module "monitoring" {
  source = "../../modules/monitoring"
  name   = "${var.name}"

  alarm_topic_arn = "${var.alarm_topic_arn}"

  iam_role_name = "${module.iam.role_name}"

  log_retention_in_days = "${var.log_retention_in_days}"
}

data "aws_iam_role" "role" {
  name = "${module.iam.role_name}"
}

resource "aws_lambda_function" "lambda_function" {
  description   = "${var.description}"
  function_name = "${var.name}"

  s3_bucket         = "${var.s3_bucket}"
  s3_key            = "${var.s3_key}"
  s3_object_version = "${data.aws_s3_bucket_object.package.version_id}"

  role    = "${data.aws_iam_role.role.arn}"
  handler = "${var.module_name == "" ? "${var.name}.main": "${var.module_name}.main"}"
  runtime = "python3.6"
  timeout = "${var.timeout}"

  memory_size = "${var.memory_size}"

  dead_letter_config = {
    target_arn = "${module.monitoring.dlq_arn}"
  }

  vpc_config {
    security_group_ids = ["${var.security_group_ids}"]
    subnet_ids         = ["${var.subnet_ids}"]
  }

  environment {
    variables = "${var.environment_variables}"
  }
}