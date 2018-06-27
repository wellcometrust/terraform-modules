output "name" {
  value = "${aws_launch_configuration.launch_config.name}"
}

output "ebs_volume_id" {
  value = "${var.ebs_device_name}"
}
