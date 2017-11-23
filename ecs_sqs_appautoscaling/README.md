# ecs_sqs_appautoscaling

Allow ECS services to scale dynamically based on queue length.

Intended for ECS worker service pattern where services are fed from a queue.

## Usage:
```tf
module "my_service_sqs_appautoscaling" {
  source  = "git::https://github.com/wellcometrust/terraform.git//ecs_alb?ref=v1.0.0"
  name    = "api"

  queue_name   = "my_queue"
  cluster_name = "my_cluster"
  service_name = "my_service"

  min_capacity = 0
  max_capacity = 1
}
```