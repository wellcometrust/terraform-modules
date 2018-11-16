output "subnets" {
  value = ["${module.subnets.subnets}"]
}

output "route_table_id" {
  value = "${module.subnets.route_table_id}"
}

output "az_count" {
  value = "${var.az_count}"
}
