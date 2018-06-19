module "cloudformation_stack" {
  source = "../../modules/asg"

  subnet_list        = "${var.subnet_list}"
  asg_name           = "${var.name}"
  launch_config_name = "${module.launch_config.name}"

  asg_max     = "${var.asg_max}"
  asg_desired = "${var.asg_desired}"
  asg_min     = "${var.asg_min}"
}

module "launch_config" {
  source = "../../modules/launch_config/ebs"

  instance_profile_name = "${module.instance_profile.name}"

  vpc_id                      = "${var.vpc_id}"
  asg_name                    = "${var.name}"
  image_id                    = "${var.image_id}"
  user_data                   = "${var.user_data}"
  key_name                    = "${var.key_name}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = "${var.public_ip}"

  instance_security_groups = ["${module.security_groups.instance_security_groups}"]

  ebs_size = "${var.ebs_size}"
}

module "security_groups" {
  source = "../../modules/security_groups"

  name   = "${var.name}"
  vpc_id = "${var.vpc_id}"

  controlled_access_cidr_ingress    = ["${var.controlled_access_cidr_ingress}"]
  controlled_access_security_groups = ["${var.ssh_ingress_security_groups}"]
  custom_security_groups            = ["${var.custom_security_groups}"]
}

module "instance_profile" {
  source = "../../modules/instance_profile"
  name   = "${var.name}"
}
