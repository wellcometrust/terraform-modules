# Cluster

Module for creating a ECS Cluster with:

- ASGs providing ECS host instances
  - One ASG providing spot instances
  - Another providing on-demand instance
  - Autoscaling rules to add on-demand instances when spot instances too costly.
  - Autoscaling rules to scale up the amount of spot instances requested when CPU reservation is high.

```tf
module "my_cluster" {
  source = "cluster"
  name   = "my_cluster"

  vpc_subnets = ["${var.vpc_subnets}"]
  vpc_id      = "${var.vpc_id}"

  key_name = "${var.vpc_id}"

  ec2_terminating_topic_arn                       = "${var.ec2_terminating_topic_arn}"
  ec2_terminating_topic_publish_policy            = "${var.ec2_terminating_topic_publish_policy}"
  ec2_instance_terminating_for_too_long_alarm_arn = "${var.ec2_instance_terminating_for_too_long_alarm_arn}"

  alb_log_bucket_id = "${var.alb_log_bucket_id}"
}
```