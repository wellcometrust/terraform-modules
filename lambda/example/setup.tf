# Topics required by module

module "trigger_topic" {
  source = "../../sns"

  name = "${local.namespace}_MyTriggerTopic"
}

module "alarm_topic" {
  source = "../../sns"

  name = "${local.namespace}_MyAlarmTopic"
}

# Create and store example lambda

locals {
  lambda_file_key = "MyExampleFunction.zip"
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "${local.namespace}_MyExampleBucket"
  acl    = "private"
}

resource "aws_s3_bucket_object" "example_lambda_zip" {
  bucket = "${aws_s3_bucket.example_bucket.bucket}"
  key    = "${local.lambda_file_key}"
  source = "${local.lambda_file_key}"
  etag   = "${md5(file(local.lambda_file_key))}"
}