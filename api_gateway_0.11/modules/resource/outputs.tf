output "http_method" {
  value = "${var.http_method}"
}

output "resource_id" {
  value = "${aws_api_gateway_resource.resource.id}"
}
