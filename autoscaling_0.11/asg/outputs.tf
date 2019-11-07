output "scale_down_arn" {
  value = "${module.scale_down.asg_scale_arn}"
}

output "scale_up_arn" {
  value = "${module.scale_up.asg_scale_arn}"
}
