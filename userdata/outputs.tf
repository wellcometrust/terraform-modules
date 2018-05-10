output "rendered" {
  value = "${data.template_file.template.rendered}"
}

output "mount_directories" {
  value = "${local.mount_directories}"
}
