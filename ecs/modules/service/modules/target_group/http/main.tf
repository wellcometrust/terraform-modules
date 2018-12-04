resource "aws_alb_target_group" "http" {
  # Must only contain alphanumerics and hyphens.
  name = "${local.target_group_name}"

  target_type = "ip"

  protocol = "HTTP"
  port     = "${var.container_port}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "HTTP"
    path     = "${var.healthcheck_path}"
    matcher  = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${var.lb_arn}"
  port              = "${var.listener_port}"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.http.arn}"
  }
}
