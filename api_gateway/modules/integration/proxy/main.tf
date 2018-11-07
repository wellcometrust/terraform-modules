locals {
  domain = "${var.hostname}:${var.forward_port}"
  uri    = "http://${local.domain}/${var.forward_path}"
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id = "${var.api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${var.http_method}"

  integration_http_method = "${var.integration_method}"
  type                    = "HTTP"
  connection_type         = "VPC_LINK"
  connection_id           = "${var.connection_id}"
  uri                     = "${local.uri}"

  request_parameters = "${var.request_parameters}"
}

module "cors" {
  source = "../../cors"

  api_id          = "${var.api_id}"
  api_resource_id = "${var.resource_id}"
  http_method     = "${var.http_method}"
}

# Adds CORS preflight headers

resource "aws_api_gateway_method" "option" {
  rest_api_id   = "${var.api_id}"
  resource_id   = "${var.resource_id}"
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "option" {
  rest_api_id = "${var.api_id}"
  resource_id = "${var.resource_id}"
  http_method = "OPTIONS"

  type = "MOCK"

  request_templates {
    "application/json" = "{ \"statusCode\": 200 }"
  }
}

module "cors_option" {
  source = "../../cors"

  api_id          = "${var.api_id}"
  api_resource_id = "${var.resource_id}"
  http_method     = "OPTIONS"
}
