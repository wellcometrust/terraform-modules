locals {
  domain     = "${var.proxied_hostname}:${var.forward_port}"
  uri        = "http://${local.domain}/${var.forward_path}"
  auth_scope = "${var.cognito_api_id}/${var.resource_name}"
}