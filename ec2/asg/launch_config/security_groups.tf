resource "aws_security_group" "ssh_controlled_ingress" {
  description = "controls direct access to application instances"
  vpc_id      = "${var.vpc_id}"
  name_prefix = "${var.asg_name}_ssh_controlled_ingress"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [
      "${var.admin_cidr_ingress}",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "full_egress" {
  description = "controls direct access to application instances"
  vpc_id      = "${var.vpc_id}"
  name_prefix = "${var.asg_name}_full_egress"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
