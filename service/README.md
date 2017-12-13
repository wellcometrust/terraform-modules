# ECS Service

Creates an ECS service, task definition, config and IAM permissions.

## Usage

You can create a module like so:

```tf
module "my_service" {
  source = "service"
  name   = "my_service"

  cluster_id = "${var.cluster_id}"
  vpc_id     = "${var.vpc_id}"

  infra_bucket = "${var.infra_bucket}"
  config_key   = "${var.config_key}"

  config_vars = {
    IP_ADDRESS = "192.0.2.6"
    HOST       = "localhost"
    ...
  }

  listener_https_arn = "${var.listener_https_arn}"
  listener_http_arn  = "${var.listener_http_arn}"

  loadbalancer_cloudwatch_id = "${var.loadbalancer_cloudwatch_id}"

  server_error_alarm_topic_arn = "${var.server_error_alarm_topic_arn}"
  client_error_alarm_topic_arn = "${var.client_error_alarm_topic_arn}"
}
```