output "rendered" {
  value = "${data.template_file.template.rendered}"
}

output "mount_directory" {
  value = "${local.mount_directory}"
}
