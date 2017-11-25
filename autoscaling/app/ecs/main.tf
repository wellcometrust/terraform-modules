module "scale_up" {
  source = "./appautoscaling_policy"
  name   = "${var.name}-scale-up"

  cluster_name = "${var.cluster_name}"
  service_name = "${var.service_name}"

  scaling_adjustment = "${var.scale_up_adjustment}"

  depends_on = ["${aws_appautoscaling_target.service_scale_target.id}"]
}

module "scale_down" {
  source = "./appautoscaling_policy"
  name   = "${var.name}-scale-down"

  cluster_name = "${var.cluster_name}"
  service_name = "${var.service_name}"

  scaling_adjustment = "${var.scale_down_adjustment}"

  depends_on = ["${aws_appautoscaling_target.service_scale_target.id}"]
}

resource "aws_appautoscaling_target" "service_scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = "${aws_iam_role.ecs_autoscale_role.arn}"

  min_capacity = "${var.min_capacity}"
  max_capacity = "${var.max_capacity}"
}
