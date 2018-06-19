module "cloudformation_stack" {
  source = "../../modules/asg"

  subnet_list        = "${var.subnet_list}"
  asg_name           = "${var.name}"
  launch_config_name = "${module.launch_config.name}"

  asg_min     = "0"
  asg_desired = "${var.enabled ? 1 : 0}"
  asg_max     = "1"
}

module "launch_config" {
  source = "../../modules/launch_config/spot"

  instance_profile_name = "${module.instance_profile.name}"

  vpc_id                      = "${var.vpc_id}"
  asg_name                    = "${var.name}"
  image_id                    = "${var.image_id}"
  user_data                   = "${data.template_file.userdata.rendered}"
  key_name                    = "${var.key_name}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = true

  instance_security_groups = ["${module.security_groups.instance_security_groups}"]
  spot_price               = "${var.spot_price}"
}

module "security_groups" {
  source = "../../modules/security_groups"

  name   = "${var.name}"
  vpc_id = "${var.vpc_id}"

  custom_security_groups         = ["${var.custom_security_groups}"]
  controlled_access_cidr_ingress = ["${var.controlled_access_cidr_ingress}"]
}

module "instance_profile" {
  source = "../../modules/instance_profile"
  name   = "${var.name}"
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.sh.tpl")}"

  vars {
    notebook_user       = "jupyter"
    notebook_port       = "8888"
    hashed_password     = "${var.hashed_password}"
    bucket_name         = "${var.bucket_name}"
    default_environment = "${var.default_environment}"
  }
}

resource "aws_autoscaling_schedule" "scale_down" {
  scheduled_action_name  = "ensure_down"
  min_size               = 0
  max_size               = 1
  desired_capacity       = 0
  recurrence             = "0 20 * * *"
  autoscaling_group_name = "${module.cloudformation_stack.asg_name}"
}
