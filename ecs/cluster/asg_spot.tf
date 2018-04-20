module "cluster_asg_spot_autoscaling" {
  source = "../../autoscaling/asg"
  name   = "${var.name}_spot"

  scalegroup_name = "${module.cluster_asg_spot.asg_name}"
}

module "cluster_asg_spot_cpureservation_autoscaling_alarms" {
  source = "../../autoscaling/alarms/cpureservation"
  name   = "${var.name}_spot"

  cluster_name = "${aws_ecs_cluster.cluster.name}"

  scale_up_arn           = "${module.cluster_asg_spot_autoscaling.scale_up_arn}"
  scale_down_arn         = "${module.cluster_asg_spot_autoscaling.scale_down_arn}"
  high_period_in_minutes = "${var.scale_up_period_in_minutes}"
  low_period_in_minutes  = "${var.scale_down_period_in_minutes}"
}

module "cluster_asg_spot" {
  source = "asg"
  name   = "${var.name}-cluster-spot"

  subnet_list = ["${var.vpc_subnets}"]
  key_name    = "${var.key_name}"

  user_data          = "${module.cluster_userdata.rendered}"
  vpc_id             = "${var.vpc_id}"
  admin_cidr_ingress = "${var.admin_cidr_ingress}"

  asg_min     = "${var.asg_spot_min}"
  asg_desired = "${var.asg_spot_desired}"
  asg_max     = "${var.asg_spot_max}"

  image_id      = "${data.aws_ami.stable_coreos.id}"
  instance_type = "${var.asg_spot_instance_type}"

  use_spot   = 1
  spot_price = "${var.asg_spot_price}"

  sns_topic_arn         = "${var.ec2_terminating_topic_arn}"
  publish_to_sns_policy = "${var.ec2_terminating_topic_publish_policy}"
  alarm_topic_arn       = "${var.ec2_instance_terminating_for_too_long_alarm_arn}"
}
