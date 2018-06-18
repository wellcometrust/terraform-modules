resource "aws_cloudwatch_log_group" "task" {
  name = "${var.log_group_prefix}/${var.task_name}"

  retention_in_days = "${var.log_retention_in_days}"
}
