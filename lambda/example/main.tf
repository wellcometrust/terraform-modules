module "lambda_public" {
  source = "../prebuilt/public"

  name        = "${local.namespace}_lambda_public"
  description = "An example public lambda"

  alarm_topic_arn = "${module.alarm_topic.arn}"

  s3_bucket = "${aws_s3_bucket.example_bucket.bucket}"
  s3_key    = "${local.lambda_file_key}"
}

module "lambda_vpc" {
  source = "../prebuilt/vpc"

  name        = "${local.namespace}_lambda_vpc"
  description = "An example public lambda"

  alarm_topic_arn = "${module.alarm_topic.arn}"

  subnet_ids = "${module.network.private_subnets}"

  security_group_ids = [
    "${aws_security_group.interservice_security_group.id}",
    "${aws_security_group.service_egress_security_group.id}",
  ]

  s3_bucket = "${aws_s3_bucket.example_bucket.bucket}"
  s3_key    = "${local.lambda_file_key}"
}
