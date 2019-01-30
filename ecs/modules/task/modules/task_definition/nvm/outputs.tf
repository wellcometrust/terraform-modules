output "task_definition_arn" {
  value = "${aws_ecs_task_definition.task.arn}"
}

output "task_role_name" {
  value = "${module.iam_roles.name}"
}

output "task_execution_role_name" {
  value = "${module.iam_roles.task_execution_role_name}"
}

output "mount_points" {
  value = "${local.mount_points}"
}
