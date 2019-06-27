output "admin_role_arn" {
  value = "${module.admin.arn}"
}

output "admin_role_name" {
  value = "${module.admin.name}"
}

output "billing_role_arn" {
  value = "${module.billing.arn}"
}

output "billing_role_name" {
  value = "${module.billing.name}"
}

output "developer_role_arn" {
  value = "${module.developer.arn}"
}

output "developer_role_name" {
  value = "${module.developer.name}"
}

output "infrastructure_role_arn" {
  value = "${module.infrastructure.arn}"
}

output "infrastructure_role_name" {
  value = "${module.infrastructure.name}"
}

output "read_only_role_arn" {
  value = "${module.read_only.arn}"
}

output "read_only_role_name" {
  value = "${module.read_only.name}"
}