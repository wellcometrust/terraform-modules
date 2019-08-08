# Roles

module "admin_role" {
  source = "../../../modules/assumable_role/aws"
  name   = "${var.prefix}-admin"

  max_session_duration_in_seconds = "${var.max_session_duration_in_seconds}"

  principals = ["${var.principal}"]
}

module "admin_role_policy" {
  source    = "../../role_policies/admin"
  role_name = "${module.admin_role.name}"
}

module "billing_role" {
  source = "../../../modules/assumable_role/aws"
  name   = "${var.prefix}-billing"

  max_session_duration_in_seconds = "${var.max_session_duration_in_seconds}"

  principals = ["${var.principal}"]
}

module "billing_role_policy" {
  source    = "../../role_policies/billing"
  role_name = "${module.billing_role.name}"
}

module "developer_role" {
  source = "../../../modules/assumable_role/aws"
  name   = "${var.prefix}-developer"

  max_session_duration_in_seconds = "${var.max_session_duration_in_seconds}"

  principals = ["${var.principal}"]
}

module "developer_role_policy" {
  source    = "../../role_policies/developer"
  role_name = "${module.developer_role.name}"
}

module "monitoring_role" {
  source = "../../../modules/assumable_role/aws"
  name   = "${var.prefix}-monitoring"

  max_session_duration_in_seconds = "${var.max_session_duration_in_seconds}"

  principals = ["${var.principal}"]
}

module "monitoring_role_policy" {
  source    = "../../role_policies/monitoring"
  role_name = "${module.monitoring_role.name}"
}

module "read_only_role" {
  source = "../../../modules/assumable_role/aws"
  name   = "${var.prefix}-read_only"

  max_session_duration_in_seconds = "${var.max_session_duration_in_seconds}"

  principals = ["${var.principal}"]
}

module "read_only_role_policy" {
  source    = "../../role_policies/read_only"
  role_name = "${module.read_only_role.name}"
}

module "publisher_role" {
  source = "../../../modules/assumable_role/aws"
  name   = "${var.prefix}-publisher"

  max_session_duration_in_seconds = "${var.max_session_duration_in_seconds}"

  principals = ["${var.principal}"]
}

module "publisher_role_policy" {
  source    = "../../role_policies/publisher"
  role_name = "${module.publisher_role.name}"
}
