output "name" {
  value = "${element(concat(aws_launch_configuration.spot_launch_config.*.name, aws_launch_configuration.ondemand_launch_config.*.name), 0)}"
}
