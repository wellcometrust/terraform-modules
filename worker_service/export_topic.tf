resource "aws_sns_topic" "worker_service_export_topic" {
  name = "${var.name}"
}
