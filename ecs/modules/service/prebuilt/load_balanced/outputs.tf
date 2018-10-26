output "service_name" {
  value = "${var.service_name}"
}

output "target_group_name" {
  value = "${replace(var.service_name, "_", "-")}"
}