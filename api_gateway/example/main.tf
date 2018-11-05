module "resource" {
  source = "../modules/resource"

  namespace     = "${local.namespace}"
  resource_name = "${local.external_path}"

  api_id               = "${module.gateway.id}"
  api_root_resource_id = "${module.gateway.root_resource_id}"

  cognito_api_id = "${aws_cognito_resource_server.api.identifier}"
  authorizer_id  = "${aws_api_gateway_authorizer.cognito.id}"

  proxied_hostname = "www.example.com"

  forward_port     = "${local.internal_port}"
  forward_path     = "${local.internal_path}"

  target_arns = ["${module.nlb.arn}"]
}

module "gateway" {
  source = "../modules/gateway"

  name  = "Example API"
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = "${module.gateway.id}"
  stage_name  = "v1"
}