locals {
  integration_domain  = "${var.hostname}:${var.load_balancer_port}"
  integration_uri     = "http://${integration_domain}/${var.forward_path}"
  authorization_scope = "${var.cognito_storage_api_identifier}/${var.resource_name}"
}
