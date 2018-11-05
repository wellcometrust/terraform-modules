resource "aws_lb" "network_load_balancer" {
  name               = "${replace("${var.namespace}", "_", "-")}-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = ["${var.private_subnets}"]
}