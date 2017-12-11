module "cluster_asg_on_demand_autoscaling" {
  source = "git::https://github.com/wellcometrust/terraform.git//autoscaling/asg?ref=v1.1.0"
  name   = "${var.name}_on_demand"

  scalegroup_name = "${module.cluster_asg_on_demand_autoscaling.asg_name}"
}

module "cluster_asg_on_demand_asg_totalinstances_autoscaling_alarms" {
  source = "git::https://github.com/wellcometrust/terraform.git//autoscaling/alarms/asg_totalinstances?ref=v1.1.0"
  name   = "${var.name}_on_demand"

  asg_name = "${module.cluster_asg_spot.asg_name}"

  scale_up_arn   = "${module.cluster_asg_on_demand_autoscaling.scale_up_arn}"
  scale_down_arn = "${module.cluster_asg_on_demand_autoscaling.scale_down_arn}"
}

module "cluster_asg_on_demand" {
  source = "asg"
  name   = "${var.name}-cluster-on-demand"

  subnet_list = ["${var.vpc_subnets}"]
  key_name    = "${var.key_name}"

  user_data          = "${module.cluster_userdata.rendered}"
  vpc_id             = "${var.vpc_id}"
  admin_cidr_ingress = "${var.admin_cidr_ingress}"

  asg_min     = "${var.asg_on_demand_min}"
  asg_desired = "${var.asg_on_demand_desired}"
  asg_max     = "${var.asg_on_demand_max}"

  image_id      = "${data.aws_ami.stable_coreos.id}"
  instance_type = "${var.asg_on_demand_instance_type}"

  sns_topic_arn         = "${var.ec2_terminating_topic_arn}"
  publish_to_sns_policy = "${var.ec2_terminating_topic_publish_policy}"

  alarm_topic_arn = "${var.ec2_instance_terminating_for_too_long_alarm_arn}"
}
