output "name" {
  value = "${element(concat(aws_launch_configuration.spot_launch_config.*.name, aws_launch_configuration.ondemand_launch_config.*.name), 0)}"
}
output "ssh_controlled_ingress_sg" {
  value = "${aws_security_group.ssh_controlled_ingress.id}"
}
