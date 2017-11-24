# ecs_appautoscaling/autoscaling

Allow ECS services to scale dynamically.

## Usage:
```tf
module "my_service_appautoscaling" {
  source  = "git::https://github.com/wellcometrust/terraform.git//ecs_appautoscaling/appautoscaling?ref=ecs-sqs-autoscaling-policy"
  name    = "api"

  cluster_name = "my_cluster"
  service_name = "my_service"
}

# Then reference scale_down_arn/scale_up_arn in your alarms

resource "aws_cloudwatch_metric_alarm" "my_low_alarm" {
  # ...

  alarm_actions = [
    "${module.my_service_appautoscaling.scale_down_arn}",
  ]
}

resource "aws_cloudwatch_metric_alarm" "my_high_alarm" {
  # ...

  alarm_actions = [
    "${module.my_service_appautoscaling.scale_up_arn}",
  ]
}
```
