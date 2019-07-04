resource "aws_config_configuration_recorder" "config-recorder" {
  name     = "${var.name}"
  role_arn = "${var.role_arn}"

  recording_group {
    all_supported                 = "${var.all_supported}"
    include_global_resource_types = "${var.include_global_resource_types}"
  }
}
