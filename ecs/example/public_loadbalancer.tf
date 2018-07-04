# ALB for public services

resource "aws_alb" "public_services" {
  # This name can only contain alphanumerics and hyphens
  name = "${replace("${local.namespace}", "_", "-")}"

  subnets         = ["${module.network.public_subnets}"]
  security_groups = ["${aws_security_group.service_lb_security_group.id}", "${aws_security_group.external_lb_security_group.id}"]
}

# Listener for ecs_fargate_public

resource "aws_alb_listener" "http_80" {
  load_balancer_arn = "${aws_alb.public_services.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${module.ecs_fargate_public.target_group_arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "path_rule_80" {
  listener_arn = "${aws_alb_listener.http_80.arn}"

  action {
    type             = "forward"
    target_group_arn = "${module.ecs_fargate_public.target_group_arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/"]
  }
}

# Listener for ecs_fargate_public_with_sidecar

resource "aws_alb_listener" "http_8080" {
  load_balancer_arn = "${aws_alb.public_services.id}"
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${module.ecs_fargate_public_with_sidecar.target_group_arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "path_rule_8080" {
  listener_arn = "${aws_alb_listener.http_8080.arn}"

  action {
    type             = "forward"
    target_group_arn = "${module.ecs_fargate_public_with_sidecar.target_group_arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/"]
  }
}

# Listener for ecs_ec2_public

resource "aws_alb_listener" "http_8181" {
  load_balancer_arn = "${aws_alb.public_services.id}"
  port              = "8181"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${module.ecs_ec2_public.target_group_arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "path_rule_8181" {
  listener_arn = "${aws_alb_listener.http_8181.arn}"

  action {
    type             = "forward"
    target_group_arn = "${module.ecs_ec2_public.target_group_arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/"]
  }
}
