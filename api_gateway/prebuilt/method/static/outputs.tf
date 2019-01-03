output "http_method" {
  value = "${module.method.http_method}"
}

output "integration_id" {
  value = "${module.static_integration.id}"
}
output "method_response_resource_id" {
  value = "${aws_api_gateway_method_response.200.resource_id}"
}
