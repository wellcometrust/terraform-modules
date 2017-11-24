output "scale_down_arn" {
  value = "${module.scale_down.service_scale_arn}"
}

output "scale_up_arn" {
  value = "${module.scale_up.service_scale_arn}"
}