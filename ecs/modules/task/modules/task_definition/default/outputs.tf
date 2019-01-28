output "task_definition_arn" {
  value = "${aws_ecs_task_definition.task.arn}"
}

output "task_role_arn" {
  value = "${module.iam_roles.task_role_arn}"
}

output "task_execution_role_arn" {
  value = "${module.iam_roles.task_execution_role_arn}"
}

output "task_role_name" {
  value = "${module.iam_roles.name}"
}
