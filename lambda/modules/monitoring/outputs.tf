output "dlq_arn" {
  value = "${aws_sqs_queue.lambda_dlq.arn}"
}