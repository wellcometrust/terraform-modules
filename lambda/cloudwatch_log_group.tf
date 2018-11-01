resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = "/aws/lambda/${var.name}"

  retention_in_days = "${var.log_retention_in_days}"
}