output "ssh_controlled_ingress_sg" {
  value = "${module.asg.ssh_controlled_ingress_sg}"
}

output "nvm_host_path" {
  value = "${var.nvm_host_path}"
}
