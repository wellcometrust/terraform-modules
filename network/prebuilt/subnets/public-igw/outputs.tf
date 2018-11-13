output "subnets" {
  value = ["${module.subnets.subnets}"]
}

output "az_count" {
  value = "${var.az_count}"
}
