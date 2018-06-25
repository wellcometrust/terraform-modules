resource "aws_security_group" "instance_sg" {
  description = "${var.asg_name}: SSH access"
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [
      "${var.admin_cidr_ingress}",
    ]
  }

  ingress {
    from_port = 32768
    to_port   = 61000
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.https.id}",
    ]
  }

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

resource "aws_security_group" "http" {
  description = "${var.asg_name}: HTTP access to the ELB"
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80

    cidr_blocks = [
      "${var.admin_cidr_ingress}",
    ]
  }

  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "https" {
  description = "${var.asg_name}: HTTPS access to the ELB"
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443

    cidr_blocks = [
      "${var.admin_cidr_ingress}",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}
