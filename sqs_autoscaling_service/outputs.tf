output "config_key" {
  value = "${module.service.config_key}"
}

output "task_role_name" {
  value = "${module.ecs_iam.task_role_name}"
}
