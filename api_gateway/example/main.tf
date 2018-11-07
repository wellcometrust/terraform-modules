resource "aws_api_gateway_vpc_link" "link" {
  name        = "${local.namespace}_vpc_link"
  target_arns = ["${module.nlb.arn}"]
}

resource "aws_api_gateway_rest_api" "api" {
  name = "${local.namespace}_id"

  endpoint_configuration = {
    types = ["REGIONAL"]
  }
}

module "prod" {
  source = "../modules/stage"

  domain_name      = "api.wellcomecollection.org"
  cert_domain_name = "api.wellcomecollection.org"

  stage_name  = "prod"
  api_id      = "${aws_api_gateway_rest_api.api.id}"

  variables = {
    port = "${local.nlb_listener_port}"
  }
}

module "stage" {
  source = "../modules/stage"

  domain_name      = "api-stage.wellcomecollection.org"
  cert_domain_name = "api.wellcomecollection.org"

  stage_name  = "stage"
  api_id      = "${aws_api_gateway_rest_api.api.id}"

  variables = {
    port = "${local.nlb_listener_port_stage}"
  }
}

# Simple - no auth

module "root_resource_method" {
  source = "../modules/method"

  api_id      = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_rest_api.api.root_resource_id}"
}

module "root_resource_integration" {
  source = "../modules/integration/proxy"

  api_id        = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  connection_id = "${aws_api_gateway_vpc_link.link.id}"

  hostname     = "www.example.com"
  http_method  = "${module.root_resource_method.http_method}"

  forward_port = "$${stageVariables.port}"
  forward_path = ""
}

module "simple_resource" {
  source = "../modules/resource"

  api_id      = "${aws_api_gateway_rest_api.api.id}"

  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "{proxy+}"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

module "simple_integration" {
  source = "../modules/integration/proxy"

  api_id        = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${module.simple_resource.resource_id}"
  connection_id = "${aws_api_gateway_vpc_link.link.id}"

  hostname     = "www.example.com"
  http_method  = "${module.simple_resource.http_method}"

  forward_port = "$${stageVariables.port}"
  forward_path = "{proxy}"

  request_parameters = {
    integration.request.path.proxy = "method.request.path.proxy"
  }
}

# No auth

module "resource" {
  source = "../modules/resource"

  api_id      = "${aws_api_gateway_rest_api.api.id}"

  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "resource"
}

module "resource_integration" {
  source = "../modules/integration/proxy"

  api_id        = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${module.resource.resource_id}"
  connection_id = "${aws_api_gateway_vpc_link.link.id}"

  hostname     = "www.example.com"
  http_method  = "${module.resource.http_method}"

  forward_port = "$${stageVariables.port}"
  forward_path = ""
}

module "subresource" {
  source = "../modules/resource"

  api_id      = "${aws_api_gateway_rest_api.api.id}"

  parent_id   = "${module.resource.resource_id}"
  path_part   = "{proxy+}"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

module "subresource_integration" {
  source = "../modules/integration/proxy"

  api_id        = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${module.subresource.resource_id}"
  connection_id = "${aws_api_gateway_vpc_link.link.id}"

  hostname     = "www.example.com"
  http_method  = "${module.subresource.http_method}"

  forward_port = "$${stageVariables.port}"
  forward_path = "{proxy}"

  request_parameters = {
    integration.request.path.proxy = "method.request.path.proxy"
  }
}

# Auth

module "auth_resource" {
  source = "../modules/resource"

  api_id      = "${aws_api_gateway_rest_api.api.id}"

  authorization = "COGNITO_USER_POOLS"
  authorizer_id = "${aws_api_gateway_authorizer.cognito.id}"
  auth_scopes   = ["${local.scope_id}"]

  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "auth_resource"
}

module "auth_resource_integration" {
  source = "../modules/integration/proxy"

  api_id        = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${module.auth_resource.resource_id}"
  connection_id = "${aws_api_gateway_vpc_link.link.id}"

  hostname     = "www.example.com"
  http_method  = "${module.auth_resource.http_method}"

  forward_port = "$${stageVariables.port}"
  forward_path = ""
}

module "auth_subresource" {
  source = "../modules/resource"

  api_id      = "${aws_api_gateway_rest_api.api.id}"

  authorization = "COGNITO_USER_POOLS"
  authorizer_id = "${aws_api_gateway_authorizer.cognito.id}"
  auth_scopes   = ["${local.scope_id}"]

  parent_id   = "${module.auth_resource.resource_id}"
  path_part   = "{proxy+}"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

module "auth_subresource_integration" {
  source = "../modules/integration/proxy"

  api_id        = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${module.auth_subresource.resource_id}"
  connection_id = "${aws_api_gateway_vpc_link.link.id}"

  hostname     = "www.example.com"
  http_method  = "${module.auth_subresource.http_method}"

  forward_port = "$${stageVariables.port}"
  forward_path = "{proxy}"

  request_parameters = {
    integration.request.path.proxy = "method.request.path.proxy"
  }
}
