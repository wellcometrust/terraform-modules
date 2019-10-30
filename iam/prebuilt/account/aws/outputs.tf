output "admin_role_arn" {
  value = "${module.admin_role.arn}"
}

output "billing_role_arn" {
  value = "${module.billing_role.arn}"
}

output "developer_role_arn" {
  value = "${module.developer_role.arn}"
}

output "monitoring_role_arn" {
  value = "${module.monitoring_role.arn}"
}

output "read_only_role_arn" {
  value = "${module.read_only_role.arn}"
}

output "publisher_role_arn" {
  value = "${module.publisher_role.arn}"
}

output "all_role_arns" {
  value = [
    "${module.admin_role.arn}",
    "${module.billing_role.arn}",
    "${module.developer_role.arn}",
    "${module.monitoring_role.arn}",
    "${module.read_only_role.arn}",
    "${module.publisher_role.arn}",
  ]
}

output "admin_role_name" {
  value = "${module.admin_role.name}"
}

output "billing_role_name" {
  value = "${module.billing_role.name}"
}

output "developer_role_name" {
  value = "${module.developer_role.name}"
}

output "monitoring_role_name" {
  value = "${module.monitoring_role.name}"
}

output "read_only_role_name" {
  value = "${module.read_only_role.name}"
}

output "publisher_role_name" {
  value = "${module.publisher_role.name}"
}

output "all_role_names" {
  value = [
    "${module.admin_role.name}",
    "${module.billing_role.name}",
    "${module.developer_role.name}",
    "${module.monitoring_role.name}",
    "${module.read_only_role.name}",
    "${module.publisher_role.name}",
  ]
}
