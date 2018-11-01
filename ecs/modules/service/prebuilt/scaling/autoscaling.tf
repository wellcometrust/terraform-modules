module "appautoscaling" {
  source = "../../../../../autoscaling/app/ecs"
  name   = "${module.service.service_name}"

  cluster_name = "${var.cluster_name}"
  service_name = "${module.service.service_name}"

  min_capacity = "${var.min_capacity}"
  max_capacity = "${var.max_capacity}"
}