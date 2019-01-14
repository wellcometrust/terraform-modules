module "dynamo" {
  source = "../dynamo"
  name   = "${var.name}"

  table_read_max_capacity  = "${var.table_read_max_capacity}"
  table_write_max_capacity = "${var.table_write_max_capacity}"

  billing_mode = "${var.billing_mode}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name_prefix}${lower(var.name)}"

  lifecycle {
    prevent_destroy = true
  }
}
