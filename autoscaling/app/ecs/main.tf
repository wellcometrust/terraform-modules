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

  lifecycle {
    create_before_destroy = true
  }
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

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_appautoscaling_target" "service_scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = "${aws_iam_role.ecs_autoscale_role.arn}"

  min_capacity = "${var.min_capacity}"
  max_capacity = "${var.max_capacity}"

  lifecycle {
    create_before_destroy = true

    # This is an attempt to work around a bug we saw where autoscaling targets
    # were continually deleted and recreated, but getting a complete set of
    # working autoscale targets was a bit of a "whack-a-mole" process.
    #
    # We'd see the resource get recreated continually like so:
    #
    # -/+ aws_appautoscaling_target.service_scale_target (new resource required)
    #       id:                 "service/cluster/name" => <computed> (forces new resource)
    #       max_capacity:       "3" => "3"
    #       min_capacity:       "0" => "0"
    #       resource_id:        "service/cluster/name" => "service/cluster/name"
    #       role_arn:           "arn:aws:iam::1234567890:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService" => "arn:aws:iam::1234567890:role/name_ecsAutoscaleRole" (forces new resource)
    #       scalable_dimension: "ecs:service:DesiredCount" => "ecs:service:DesiredCount"
    #       service_namespace:  "ecs" => "ecs"
    #
    # So this is a hacky fix to stop it being perpetually recreated!
    ignore_changes = ["resource_id", "role_arn"]
  }
}
