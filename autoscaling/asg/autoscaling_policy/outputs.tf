output "asg_scale_arn" {
  value = "${aws_autoscaling_policy.policy.arn}"
}
