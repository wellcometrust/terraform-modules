resource "aws_config_configuration_recorder_status" "config-recorder" {
  name       = "${var.name}"
  is_enabled = "${var.is_enabled}"
}
