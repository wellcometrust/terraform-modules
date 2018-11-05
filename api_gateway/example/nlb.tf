# Load balancer

module "nlb" {
  source = "../../load_balancer/network"

  namespace       = "${local.namespace}"
  private_subnets = "${local.subnets}"
}

# Targetting example service

data "aws_lb_target_group" "target_group" {
  name = "${module.example_rest_service.target_group_name}"
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = "${module.nlb.arn}"
  port              = "${local.external_port}"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${data.aws_lb_target_group.target_group.arn}"
  }
}
