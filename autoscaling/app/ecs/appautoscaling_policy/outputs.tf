output "service_scale_arn" {
  value = "${aws_appautoscaling_policy.policy.arn}"
}
