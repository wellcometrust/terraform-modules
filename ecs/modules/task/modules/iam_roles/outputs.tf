output "name" {
  value = "${aws_iam_role.task_role.name}"
}

output "task_role_arn" {
  value = "${aws_iam_role.task_role.arn}"
}

output "task_execution_role_arn" {
  value = "${aws_iam_role.execution_role.arn}"
}
