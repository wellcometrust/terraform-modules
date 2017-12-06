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
    my_config_var = "${var.my_config_var}"
  }

  listener_https_arn = "${var.listener_https_arn}"
  listener_http_arn  = "${var.listener_http_arn}"

  loadbalancer_cloudwatch_id = "${var.loadbalancer_cloudwatch_id}"

  server_error_alarm_topic_arn = "${var.server_error_alarm_topic_arn}"
  client_error_alarm_topic_arn = "${var.client_error_alarm_topic_arn}"
}
```

### Config

By default the service expects you to have a config template:

 `./templates/my_service.ini.template`

Relative to the terraform file containing the above service description.

Variables set in the template will be substituted as necessary.

 ```
 -some.config.var=${my_config_var}
 ```

 Inside the running container the following environment variables are set:

 - `$INFRA_BUCKET`: location of S3 bucket as described in the service module.
 - `$CONFIG_KEY`: location of config within the bucket.

Your application can then read the config from the given location.