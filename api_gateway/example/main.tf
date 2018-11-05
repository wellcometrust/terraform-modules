locals {
  namespace  = "api-gw-example"
  aws_region = "eu-west-1"
  subnets    = []
}

module "resource" {
  source = "../modules/resource"

  namespace = "${local.namespace}"
  resource_name = "somepath"

  api_id               = "${module.gateway.id}"
  api_root_resource_id = "${module.gateway.root_resource_id}"

  cognito_api_id = "${aws_cognito_resource_server.api.id}"
  authorizer_id  = "${aws_api_gateway_authorizer.cognito.id}"

  proxied_hostname = ""

  forward_port     = ""
  forward_path     = ""

  target_arns = ["${module.nlb.arn}"]
}

module "gateway" {
  source = "../modules/gateway"

  name  = "Example API"
  stage = "v1"
}

module "nlb" {
  source = "../../load_balancer/network"

  namespace = "${local.namespace}"
  private_subnets = "${local.subnets}"
}
