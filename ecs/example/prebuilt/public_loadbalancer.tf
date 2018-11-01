# ALB for public services

resource "aws_alb" "public_services" {
  # This name can only contain alphanumerics and hyphens
  name = "${replace("${local.namespace}", "_", "-")}"

  subnets         = ["${module.network.public_subnets}"]
  security_groups = ["${aws_security_group.service_lb_security_group.id}", "${aws_security_group.external_lb_security_group.id}"]
}

# Listener for rest service

data "aws_lb_target_group" "target_group" {
  name = "${module.example_rest_service.target_group_name}"
}

resource "aws_alb_listener" "http_80" {
  load_balancer_arn = "${aws_alb.public_services.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${data.aws_lb_target_group.target_group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "path_rule_80" {
  listener_arn = "${aws_alb_listener.http_80.arn}"

  action {
    type             = "forward"
    target_group_arn = "${data.aws_lb_target_group.target_group.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/"]
  }
}