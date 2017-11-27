resource "aws_appautoscaling_policy" "scale_up" {
  name               = "${var.name}-scale(${var.scale_up_adjustment})"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  resource_id        = "${local.resource_id}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = "${var.metric_interval_lower_bound_scale_up}"
      scaling_adjustment          = "${var.scale_up_adjustment}"
    }
  }

  depends_on = ["aws_appautoscaling_target.service_scale_target"]
}

resource "aws_appautoscaling_policy" "scale_down" {
  name               = "${var.name}-scale(${var.scale_down_adjustment})"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  resource_id        = "${local.resource_id}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = "${var.metric_interval_upper_bound_scale_down}"
      scaling_adjustment          = "${var.scale_down_adjustment}"
    }
  }

  depends_on = ["aws_appautoscaling_target.service_scale_target"]
}

resource "aws_appautoscaling_target" "service_scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = "${aws_iam_role.ecs_autoscale_role.arn}"

  min_capacity = "${var.min_capacity}"
  max_capacity = "${var.max_capacity}"
}
