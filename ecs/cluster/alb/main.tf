resource "aws_alb" "ecs_service" {
  # This name can only contain alphanumerics and hyphens
  name = "${replace("${var.name}", "_", "-")}"

  subnets         = ["${var.subnets}"]
  security_groups = ["${var.loadbalancer_security_groups}"]

  lifecycle {
    prevent_destroy = true
  }

  access_logs {
    bucket = "${var.alb_access_log_bucket}"
    prefix = "${var.name}"
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = "${aws_alb.ecs_service.id}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${data.aws_acm_certificate.certificate.arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.ecs_service_default.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.ecs_service.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.ecs_service_default.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "ecs_service_default" {
  # This name has to be at most 32 characters, and it only allows
  # alphanumeric characters and hyphens.
  name     = "${replace("${var.name}-default", "_", "-")}"

  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    path    = "${var.health_check_path}"
    matcher = "200"
  }
}
