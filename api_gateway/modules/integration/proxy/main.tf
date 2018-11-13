locals {
  domain = "${var.hostname}:${var.forward_port}"
  uri    = "http://${local.domain}/${var.forward_path}"
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id = "${var.api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${var.http_method}"

  integration_http_method = "${var.integration_method}"
  type                    = "HTTP_PROXY"
  connection_type         = "VPC_LINK"
  connection_id           = "${var.connection_id}"
  uri                     = "${local.uri}"

  request_parameters = "${var.request_parameters}"
}
