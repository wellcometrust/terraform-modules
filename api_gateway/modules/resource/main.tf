resource "aws_api_gateway_resource" "resource" {
  rest_api_id = "${var.api_id}"
  parent_id   = "${var.parent_id}"
  path_part   = "${var.path_part}"
}

module "method" {
  source = "../method"

  api_id      = "${var.api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"

  authorization        = "${var.authorization}"
  authorizer_id        = "${var.authorizer_id}"
  authorization_scopes = ["${var.auth_scopes}"]

  http_method = "${var.http_method}"

  request_parameters = "${var.request_parameters}"
}