locals {
  target_group_name = "${replace(var.service_name, "_", "-")}"
}
