output "service_name" {
  value = "${module.service.name}"
}

output "task_role_name" {
  value = "${module.service.task_role_name}"
}

output "task_role_arn" {
  value = "${module.service.task_role_arn}"
}

output "scale_up_arn" {
  value = "${module.appautoscaling.scale_up_arn}"
}

output "scale_down_arn" {
  value = "${module.appautoscaling.scale_down_arn}"
}
