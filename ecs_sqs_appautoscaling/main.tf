resource "aws_cloudwatch_metric_alarm" "queue_high" {
  alarm_name          = "${var.name}-queue_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"

  dimensions {
    QueueName = "${var.queue_name}"
  }

  statistic = "Average"
  namespace = "AWS/SQS"
  period    = "60"
  threshold = 1

  alarm_actions = [
    "${aws_appautoscaling_policy.service_up.arn}",
  ]
}

resource "aws_cloudwatch_metric_alarm" "queue_low" {
  alarm_name          = "${var.name}-queue_low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"

  dimensions {
    QueueName = "${var.queue_name}"
  }

  statistic = "Average"
  namespace = "AWS/SQS"
  period    = "600"
  threshold = 1

  treat_missing_data = "breaching"

  alarm_actions = [
    "${aws_appautoscaling_policy.service_down.arn}",
  ]
}

resource "aws_appautoscaling_target" "service_scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = "${aws_iam_role.ecs_autoscale_role.arn}"

  min_capacity = "${var.min_capacity}"
  max_capacity = "${var.max_capacity}"
}

resource "aws_appautoscaling_policy" "service_up" {
  name               = "${var.name}-scale-up"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [
    "aws_appautoscaling_target.service_scale_target",
  ]
}

resource "aws_appautoscaling_policy" "service_down" {
  name               = "${var.name}-scale-down"
  service_namespace  = "ecs"
  scalable_dimension = "ecs:service:DesiredCount"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [
    "aws_appautoscaling_target.service_scale_target",
  ]
}

resource "aws_iam_role" "ecs_autoscale_role" {
  name = "ecsAutoscaleRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "ecs_autoscale_role_attach" {
  name = "ecs-autoscale-role-attach"

  roles = [
    "${aws_iam_role.ecs_autoscale_role.name}",
  ]

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}
