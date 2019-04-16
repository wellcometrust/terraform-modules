resource "aws_config_delivery_channel" "config-recorder" {
  name           = "${var.name}"
  s3_bucket_name = "${var.s3_bucket_name}"
  s3_key_prefix  = "${var.s3_key_prefix}"
  depends_on     = "${var.depends_on}"

  snapshot_delivery_properties {
    delivery_frequency = "${var.delivery_frequency}"
  }
}
