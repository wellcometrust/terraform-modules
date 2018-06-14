locals {
  task_role_arn      = "${data.aws_iam_role.task_role.arn}"
  execution_role_arn = "${module.iam_role.task_execution_role_arn}"
  container_name     = "app"
}
