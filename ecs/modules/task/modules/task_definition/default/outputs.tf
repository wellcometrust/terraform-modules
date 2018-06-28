output "task_definition_arn" {
  value = "${aws_ecs_task_definition.task.arn}"
}

output "task_role_name" {
  value = "${module.iam_roles.name}"
}
