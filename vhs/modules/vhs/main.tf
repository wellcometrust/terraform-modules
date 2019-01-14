module "dynamo" {
  source = "../dynamo"
  name   = "${var.name}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name_prefix}${lower(var.name)}"
}
