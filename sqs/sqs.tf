locals {
  redrive_policy = {
    deadLetterTargetArn = "${aws_sqs_queue.dlq.arn}"
    maxReceiveCount     = "${var.max_receive_count}"
  }
}

resource "aws_sqs_queue" "q" {
  name           = "${var.queue_name}"
  policy         = "${data.aws_iam_policy_document.write_to_queue.json}"

  visibility_timeout_seconds = "${var.visibility_timeout_seconds}"
  message_retention_seconds  = "${var.message_retention_seconds}"
  max_message_size           = "${var.max_message_size}"
  delay_seconds              = "${var.delay_seconds}"
  receive_wait_time_seconds  = "${var.receive_wait_time_seconds}"

  redrive_policy = "${jsonencode("${local.redrive_policy}")}"
}

resource "aws_sqs_queue" "dlq" {
  name = "${var.queue_name}_dlq"
}
