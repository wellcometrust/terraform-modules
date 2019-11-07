output "rendered" {
  value = "${data.template_file.definition.rendered}"
}

output "container_name" {
  value = "${local.container_name}"
}
