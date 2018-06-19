output "ssh_controlled_ingress_sg" {
  value = "${module.asg.ssh_controlled_ingress_sg}"
}

output "ebs_host_path" {
  value = "${var.ebs_host_path}"
}
