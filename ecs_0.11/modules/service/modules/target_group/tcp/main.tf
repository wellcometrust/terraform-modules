resource "aws_lb_target_group" "tcp" {
  # Must only contain alphanumerics and hyphens.
  name = "${local.target_group_name}"

  target_type = "ip"

  protocol = "TCP"
  port     = "${var.container_port}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "TCP"
  }
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = "${var.lb_arn}"
  port              = "${var.listener_port}"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.tcp.arn}"
  }
}
