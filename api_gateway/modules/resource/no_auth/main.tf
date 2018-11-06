# Root resource

resource "aws_api_gateway_resource" "any" {
  rest_api_id = "${var.api_id}"
  parent_id   = "${var.api_root_resource_id}"
  path_part   = "${var.resource_name}"
}

resource "aws_api_gateway_method" "any_method" {
  rest_api_id   = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.any.id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "any" {
  rest_api_id = "${var.api_id}"
  resource_id = "${aws_api_gateway_resource.any.id}"
  http_method = "${aws_api_gateway_method.any_method.http_method}"

  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  connection_type         = "VPC_LINK"
  connection_id           = "${aws_api_gateway_vpc_link.link.id}"
  uri                     = "${local.uri}"
}

# All subpaths

resource "aws_api_gateway_resource" "subpaths" {
  rest_api_id = "${var.api_id}"
  parent_id   = "${aws_api_gateway_resource.any.id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "subpaths_any_method" {
  rest_api_id   = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.subpaths.id}"
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "subpaths" {
  rest_api_id = "${var.api_id}"
  resource_id = "${aws_api_gateway_resource.subpaths.id}"
  http_method = "${aws_api_gateway_method.subpaths_any_method.http_method}"

  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  connection_type         = "VPC_LINK"
  connection_id           = "${aws_api_gateway_vpc_link.link.id}"
  uri                     = "${local.uri}{proxy}"

  request_parameters = {
    integration.request.path.proxy = "method.request.path.proxy"
  }
}
