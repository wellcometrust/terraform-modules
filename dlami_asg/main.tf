module "compute" {
  source = "git::https://github.com/wellcometrust/terraform-modules.git//ec2/asg?ref=v9.3.0"
  name   = "${var.name}"

  image_id = "${var.ami_id}"
  key_name = "${var.key_name}"

  subnet_list = ["${var.vpc_subnets}"]
  vpc_id      = "${var.vpc_id}"

  use_spot   = 1
  spot_price = "${var.spot_price}"

  asg_min     = "0"
  asg_desired = "${var.enabled ? 1 : 0}"
  asg_max     = "1"

  instance_type = "${var.instance_type}"

  user_data = "${data.template_file.userdata.rendered}"
}

data "template_file" "jupyter_config" {
  template = "${file("${path.module}/jupyter_notebook_config.py")}"

  vars {
    notebook_user   = "jupyter"
    notebook_port   = "8888"
    hashed_password = "${var.hashed_password}"
    bucket_name     = "${var.bucket_name}"
  }
}

data "template_file" "requirements" {
  template = "${file("${path.module}/requirements.txt")}"
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.sh.tpl")}"

  vars {
    jupyter_notebook_config = "${data.template_file.jupyter_config.rendered}"
    requirements            = "${data.template_file.requirements.rendered}"
    notebook_user           = "jupyter"
    default_environment     = "${var.default_environment}"
  }
}

resource "aws_autoscaling_schedule" "scale_down" {
  scheduled_action_name  = "ensure_down"
  min_size               = 0
  max_size               = 1
  desired_capacity       = 0
  recurrence             = "0 20 * * *"
  autoscaling_group_name = "${module.compute.asg_name}"
}
