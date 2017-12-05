module "worker_service_ingest_queue" {
  source      = "git::https://github.com/wellcometrust/terraform.git//sqs?ref=v1.1.0"
  queue_name  = "${var.name}_queue"
  aws_region  = "${var.aws_region}"
  account_id  = "${data.aws_caller_identity.current.account_id}"
  topic_names = ["${var.ingest_topic_name}"]

  alarm_topic_arn = "${var.dlq_alarm_arn}"
}
