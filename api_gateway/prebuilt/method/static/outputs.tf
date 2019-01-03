output "http_method" {
  value = "${module.method.http_method}"
}

output "integration_id" {
  value = "${module.static_integration.id}"
}
output "integration_uri" {
  value = "${module.static_integration.uri}"
}
