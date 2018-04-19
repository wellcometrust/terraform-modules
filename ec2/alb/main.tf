resource "aws_alb" "alb" {
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

resource "aws_alb_target_group" "target_group" {
  # This name has to be at most 32 characters, and it only allows
  # alphanumeric characters and hyphens.
  name = "${replace("${var.name}-ssh", "_", "-")}"

  port     = 22
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
}
