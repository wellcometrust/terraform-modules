output "service_name" {
  value = "${module.service.service_name}"
}

output "scale_up_arn" {
  value = "${module.appautoscaling.scale_up_arn}"
}

output "scale_down_arn" {
  value = "${module.appautoscaling.scale_down_arn}"
}
