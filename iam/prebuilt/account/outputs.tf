output "admin_role_arn" {
  value = "${module.admin.arn}"
}

output "billing_role_arn" {
  value = "${module.billing.arn}"
}

output "developer_role_arn" {
  value = "${module.developer.arn}"
}

output "infrastructure_role_arn" {
  value = "${module.infrastructure.arn}"
}

output "read_only_role_arn" {
  value = "${module.read_only.arn}"
}

output "admin_role_name" {
  value = "${module.admin.name}"
}

output "billing_role_name" {
  value = "${module.billing.name}"
}

output "developer_role_name" {
  value = "${module.developer.name}"
}

output "infrastructure_role_name" {
  value = "${module.infrastructure.name}"
}

output "read_only_role_name" {
  value = "${module.read_only.name}"
}

output "terraform_root_user_arn" {
  value = "${module.terraform_root_user.arn}"
}

output "terraform_root_user_id" {
  value = "${module.terraform_root_user.id}"
}

output "terraform_root_user_secret" {
  value = "${module.terraform_root_user.secret}"
}
