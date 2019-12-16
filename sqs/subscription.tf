resource "aws_sns_topic_subscription" "sns_topic" {
  count     = "${var.topic_count}"
  protocol  = "sqs"
  topic_arn = "${element(var.topic_arns, count.index)}"
  endpoint  = "${aws_sqs_queue.q.arn}"
}

locals {
  incorrect_topic_count = "${length(var.topic_arns) == var.topic_count ? 0 : 1}"
}

resource "null_resource" "topic_count_check" {
  count                                                                                = "${local.incorrect_topic_count}"
  "ERROR: You need to update the value of the topic_count variable in your SNS module" = true
}
