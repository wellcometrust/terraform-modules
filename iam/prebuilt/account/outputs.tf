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

output "terraform_root_user_arn" {
  value = "${module.terraform_root_user.arn}"
}

output "terraform_root_user_id" {
  value = "${module.terraform_root_user.id}"
}

output "terraform_root_user_secret" {
  value = "${module.terraform_root_user.secret}"
}
