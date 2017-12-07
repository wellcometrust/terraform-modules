module "cluster_asg_spot_autoscaling" {
  source = "git::https://github.com/wellcometrust/terraform.git//autoscaling/asg?ref=v1.1.0"
  name   = "services_spot"

  scalegroup_name = "${module.cluster_asg_spot.asg_name}"
}

module "cluster_asg_spot_cpureservation_autoscaling_alarms" {
  source = "git::https://github.com/wellcometrust/terraform.git//autoscaling/alarms/cpureservation?ref=v1.1.0"
  name   = "services_spot"

  cluster_name = "${aws_ecs_cluster.cluster.name}"

  scale_up_arn   = "${module.cluster_asg_spot_autoscaling.scale_up_arn}"
  scale_down_arn = "${module.cluster_asg_spot_autoscaling.scale_down_arn}"
}

module "cluster_asg_spot" {
  source                = "asg"
  name                  = "${var.name}-cluster-spot"

  subnet_list           = ["${var.vpc_subnets}"]
  key_name              = "${var.key_name}"

  user_data             = "${module.cluster_userdata.rendered}"
  vpc_id                = "${var.vpc_id}"
  admin_cidr_ingress    = "${var.admin_cidr_ingress}"

  asg_min     = "1"
  asg_desired = "2"
  asg_max     = "4"

  image_id      = "${data.aws_ami.stable_coreos.id}"
  instance_type = "m4.xlarge"

  use_spot   = 1
  spot_price = "0.1"

  sns_topic_arn         = "${var.ec2_terminating_topic_arn}"
  publish_to_sns_policy = "${var.ec2_terminating_topic_publish_policy}"
  alarm_topic_arn       = "${var.ec2_instance_terminating_for_too_long_alarm_arn}"
}
