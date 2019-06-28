module "admin" {
  source     = "../assumable_roles/admin"
  principals = ["${var.admin_principals}"]
  auth_type  = "${var.auth_type}"
}

module "billing" {
  source     = "../assumable_roles/billing"
  principals = ["${var.billing_principals}"]
  auth_type  = "${var.auth_type}"
}

module "developer" {
  source     = "../assumable_roles/developer"
  principals = ["${var.developer_principals}"]
  auth_type  = "${var.auth_type}"
}

module "infrastructure" {
  source     = "../assumable_roles/infrastructure"
  principals = ["${var.infrastructure_principals}"]
  auth_type  = "${var.auth_type}"
}

module "monitoring" {
  source     = "../assumable_roles/monitoring"
  principals = ["${var.monitoring_principals}"]
  auth_type  = "${var.auth_type}"
}

module "read_only" {
  source     = "../assumable_roles/read_only"
  principals = ["${var.read_only_principals}"]
  auth_type  = "${var.auth_type}"
}