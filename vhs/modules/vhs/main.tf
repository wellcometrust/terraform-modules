module "dynamo" {
  source = "../dynamo"
  name   = "${var.name}"

  protected = "${var.protected}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name_prefix}${lower(var.name)}"

  lifecycle {
    prevent_destroy = "${var.protected}"
  }
}
