resource "aws_alb_target_group" "ecs_service" {
  # We use snake case in a lot of places, but ALB Target Group names can
  # only contain alphanumerics and hyphens.
  name = "${replace(var.service_name, "_", "-")}"

  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "HTTP"
    path     = "${var.healthcheck_path}"
    matcher  = "200"
  }
}

# This is based on the example from the Terraform docs:
# https://www.terraform.io/docs/providers/random/r/integer.html#example-usage
resource "random_integer" "fallback_alb_priority" {
  min = 1
  max = 50000

  keepers = {
    listener_https_arn = "${var.listener_https_arn}"
    listener_http_arn  = "${var.listener_http_arn}"
  }

  seed = "${var.service_name}"
}

locals {
  alb_priority = "${var.alb_priority != "" ? var.alb_priority : random_integer.fallback_alb_priority.result}"
  listener_arns = ["${var.listener_http_arn}", "${var.listener_https_arn}"]
}

# When using the module, the user can specify a path pattern and (optionally)
# a hostname pattern.  We only want a path rule OR a hostname/path rule, but
# not both.  We use the `count` parameter to only create one of these.

resource "aws_alb_listener_rule" "path_rule" {
  count        = "${var.host_name == "" ? 2 : 0}"
  listener_arn = "${element(local.listener_arns, count.index)}"
  priority     = "${local.alb_priority}"

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.ecs_service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["${var.path_pattern}"]
  }
}

resource "aws_alb_listener_rule" "path_host_rule" {
  count        = "${var.host_name != "" ? 2 : 0}"
  listener_arn = "${element(local.listener_arns, count.index)}"
  priority     = "${local.alb_priority}"

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.ecs_service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["${var.path_pattern}"]
  }

  condition {
    field  = "host-header"
    values = ["${var.host_name}"]
  }
}
