output "rendered" {
  value = "${element(concat(data.template_file.custom_definition.*.rendered, data.template_file.definition.*.rendered), 0)}"
}
