output "scale_down_arn" {
  value = "${aws_appautoscaling_policy.scale_down.arn}"
}

output "scale_up_arn" {
  value = "${aws_appautoscaling_policy.scale_up.arn}"
}
