locals {
  auth_count    = "${var.authorization == "" ? 0 : 1}"
  no_auth_count = "${var.authorization == "" ? 1 : 0}"
}

resource "aws_api_gateway_method" "auth" {
  count = "${local.auth_count}"

  rest_api_id = "${var.api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${var.http_method}"

  authorization        = "${var.authorization}"
  authorizer_id        = "${var.authorizer_id}"
  authorization_scopes = ["${var.authorization_scopes}"]

  request_parameters = "${var.request_parameters}"
}

resource "aws_api_gateway_method" "no_auth" {
  count = "${local.no_auth_count}"

  rest_api_id = "${var.api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${var.http_method}"

  authorization = "NONE"

  request_parameters = "${var.request_parameters}"
}
