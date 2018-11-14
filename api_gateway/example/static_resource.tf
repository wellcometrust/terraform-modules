locals {
  bucket_name = "${local.namespace}-wellcome-tf-examples"
  key         = "response.json"

  file = "response.json"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${local.bucket_name}"
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${local.bucket_name}"
  key    = "${local.key}"
  source = "${local.file}"
  etag   = "${md5(file(local.file))}"
}

resource "aws_iam_role" "static_resource_role" {
  assume_role_policy = "${data.aws_iam_policy_document.api_gateway_assume_role.json}"
}

data "aws_iam_policy_document" "api_gateway_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "allow_gateway_s3_access" {
  policy = "${data.aws_iam_policy_document.static_content_get.json}"
  role   = "${aws_iam_role.static_resource_role.id}"
}

data "aws_iam_policy_document" "static_content_get" {
  statement {
    actions = [
      "s3:GetObject*",
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}/${local.key}",
    ]
  }
}