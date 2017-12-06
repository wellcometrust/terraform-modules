output "export_topic_name" {
  description = "Name of the export SNS topic"
  value       = "${aws_sns_topic.worker_service_export_topic.name}"
}
