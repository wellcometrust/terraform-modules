resource "aws_cloudwatch_log_group" "task" {
  name = "${var.log_group_name_prefix}/${var.name}"

  retention_in_days = "${var.log_retention_in_days}"
}

resource "aws_cloudwatch_log_group" "nginx_task" {
  name = "${var.log_group_name_prefix}/nginx_${var.name}"

  retention_in_days = "${var.log_retention_in_days}"
}
