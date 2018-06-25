module "cloudformation_stack" {
  source = "../../modules/asg"

  asg_name = "${var.name}"

  asg_max     = "${var.asg_max}"
  asg_desired = "${var.asg_desired}"
  asg_min     = "${var.asg_min}"

  subnet_list        = "${var.subnet_list}"
  launch_config_name = "${module.launch_config.name}"
}

module "launch_config" {
  source = "../../modules/launch_config/ondemand"

  key_name              = "${var.key_name}"
  image_id              = "${var.image_id}"
  instance_type         = "${var.instance_type}"
  instance_profile_name = "${module.instance_profile.name}"
  user_data             = "${var.user_data}"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  instance_security_groups    = ["${module.security_groups.instance_security_groups}"]
}

module "security_groups" {
  source = "../../modules/security_groups"

  name   = "${var.name}"
  vpc_id = "${var.vpc_id}"

  custom_security_groups            = ["${var.custom_security_groups}"]
  controlled_access_cidr_ingress    = ["${var.controlled_access_cidr_ingress}"]
  controlled_access_security_groups = ["${var.ssh_ingress_security_groups}"]
}

module "instance_profile" {
  source = "../../modules/instance_profile"

  name = "${var.name}"
}
