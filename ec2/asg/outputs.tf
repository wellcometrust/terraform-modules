output "instance_sg_id" {
  value = "${module.launch_config.instance_sg_id}"
}

output "asg_name" {
  value = "${module.cloudformation_stack.asg_name}"
}

output "asg_desired" {
  value = "${var.asg_desired}"
}

output "asg_max" {
  value = "${var.asg_max}"
}

output "instance_profile_name" {
  value = "${module.instance_profile.name}"
}

output "instance_profile_role_name" {
  value = "${module.instance_profile.role_name}"
}
