output "task_role_name" {
  value = "${module.task.task_role_name}"
}

output "target_group_name" {
  value = "${module.service.target_group_name}"
}
