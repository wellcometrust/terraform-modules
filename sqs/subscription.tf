resource "aws_sns_topic_subscription" "sns_topic" {
  count     = "${var.topic_count}"
  protocol  = "sqs"
  topic_arn = "${element(var.topic_arns, count.index)}"
  endpoint  = "${aws_sqs_queue.q.arn}"
}
