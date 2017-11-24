resource "aws_appautoscaling_policy" "policy" {
  name               = "${var.name}-scale(${var.scaling_adjustment})"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = "${var.scaling_adjustment}"
    }
  }
}
