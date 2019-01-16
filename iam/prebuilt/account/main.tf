module "admin" {
  source     = "../assumable_roles/admin"
  principals = ["${var.admin_principals}"]
}

module "billing" {
  source     = "../assumable_roles/billing"
  principals = ["${var.billing_principals}"]
}

module "developer" {
  source     = "../assumable_roles/developer"
  principals = ["${var.developer_principals}"]
}

module "infrastructure" {
  source     = "../assumable_roles/infrastructure"
  principals = ["${var.infrastructure_principals}"]
}

module "monitoring" {
  source     = "../assumable_roles/read_only"
  principals = ["${var.read_only_principals}"]
}

module "read_only" {
  source     = "../assumable_roles/read_only"
  principals = ["${var.read_only_principals}"]
}

module "terraform_root_user" {
  source  = "../users/terraform_root"
  pgp_key = "${var.pgp_key}"
}
