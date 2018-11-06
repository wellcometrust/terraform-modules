locals {
  domain = "${var.proxied_hostname}:${var.forward_port}"
  uri    = "http://${local.domain}/${var.forward_path}"
}
