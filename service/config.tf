locals {
  default_path         = "templates/${var.name}.ini.template"
  config_template_path = "${var.config_template_path == "" ? local.default_path : var.config_template_path}"
}

module "config" {
  source        = "../s3_template_file"
  s3_bucket     = "${var.infra_bucket}"
  s3_key        = "${var.config_key}"
  template_vars = "${var.config_vars}"
  template_path = "${local.config_template_path}"
  enabled       = "${var.is_config_managed}"
}
