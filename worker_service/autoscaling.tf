module "worker_service_appautoscaling" {
  source = "git::https://github.com/wellcometrust/terraform.git//autoscaling/app/ecs?ref=v1.1.0"
  name   = "${var.name}"

  cluster_name = "${var.cluster_name}"
  service_name = "${module.worker_service.service_name}"
}

module "worker_service_sqs_autoscaling_alarms" {
  source = "git::https://github.com/wellcometrust/terraform.git//autoscaling/alarms/sqs?ref=v1.1.0"
  name   = "${var.name}"

  queue_name = "${module.worker_service_ingest_queue.name}"

  scale_up_arn   = "${module.worker_service_appautoscaling.scale_up_arn}"
  scale_down_arn = "${module.worker_service_appautoscaling.scale_down_arn}"
}
