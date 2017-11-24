# ecs_appautoscaling/sqs

Allow ECS services to scale dynamically based on queue length.

Intended for ECS worker service pattern where services are fed from a queue.

## Usage:
```tf
module "my_service_sqs_appautoscaling" {
  source  = "git::https://github.com/wellcometrust/terraform.git//ecs_appautoscaling/sqs?ref=ecs-sqs-autoscaling-policy"
  name    = "api"

  queue_name   = "my_queue"

  cluster_name = "my_cluster"
  service_name = "my_service"
}
```
