resource "aws_sqs_queue" "lambda_dlq" {
  name = "lambda-${var.name}_dlq"
}
