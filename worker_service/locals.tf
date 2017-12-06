locals {
  ingest_queue_config = "${map("worker_service_ingest_queue", module.worker_service_ingest_queue.id)}"
  export_topic_config = "${map("worker_service_export_topic", aws_sns_topic.worker_service_export_topic.arn)}"

  metrics_namespace_config = "${map("metrics_namespace", var.name)}"
}
