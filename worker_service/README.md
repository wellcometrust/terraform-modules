# Worker Service

This module provides a high level abstraction on top of the services module.

A worker service consists of:

- SQS queue for ingesting units of work.
- An ECS service.
- Autoscaling rules to scale up the service when there is work to be done.
- SNS topic for exporting completed work.

The consumer needs to provide an application container that reads from SQS processes work and outputs results to SNS.

## Usage

You can instantiate a worker service module as follows:

```tf
module "example_worker_service" {
  source = "git::https://github.com/wellcometrust/terraform.git//ecs_iam?ref=worker_service"

  name = "my_worker_service"

  ingest_topic_name = "my_ingest_topic"

  cluster_name = "my_ecs_cluster"
  infra_bucket = "my_infra_bucket"

  vpc_id = "vpc-id"

  listener_https_arn = "${var.listener_https_arn}"
  listener_http_arn  = "${var.listener_http_arn}"

  alb_client_error_alarm_arn = "${var.alb_client_error_alarm_arn}"
  alb_server_error_alarm_arn = "${var.alb_server_error_alarm_arn}"

  loadbalancer_cloudwatch_id = "${var.loadbalancer_cloudwatch_id}"
  dlq_alarm_arn              = "${var.dlq_alarm_arn}"

  https_domain = "services.example.com"
}

```

### Chaining Workers

Workers can be chained together by using the `export_topic_name` output as the input to another worker service.
