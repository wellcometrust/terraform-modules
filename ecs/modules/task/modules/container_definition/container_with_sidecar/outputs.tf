output "rendered" {
  value = "${data.template_file.definition.rendered}"
}

output "app_container_name" {
  value = "${local.app_container_name}"
}

output "sidecar_container_name" {
  value = "${local.sidecar_container_name}"
}
