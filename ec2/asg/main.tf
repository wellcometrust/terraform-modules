module "cloudformation_stack" {
  source = "cloudformation"

  subnet_list        = "${var.subnet_list}"
  asg_name           = "${var.name}"
  launch_config_name = "${module.launch_config.name}"

  asg_max     = "${var.asg_max}"
  asg_desired = "${var.asg_desired}"
  asg_min     = "${var.asg_min}"
}

module "launch_config" {
  source = "launch_config"

  instance_profile_name    = "${module.instance_profile.name}"
  vpc_id                   = "${var.vpc_id}"
  asg_name                 = "${var.name}"
  image_id                 = "${var.image_id}"
  user_data                = "${var.user_data}"
  key_name                 = "${var.key_name}"
  use_spot                 = "${var.use_spot}"
  spot_price               = "${var.spot_price}"
  instance_type            = "${var.instance_type}"
  admin_cidr_ingress       = "${var.admin_cidr_ingress}"
  public_ip                = "${var.public_ip}"
#  instance_security_groups = "[${var.security_groups}]"
}

module "instance_profile" {
  source = "instance_profile"
  name   = "${var.name}"
}
