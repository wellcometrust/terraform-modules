locals {
  default_path = "templates/${var.app_name}.ini.template"
  actual_path  = "${var.config_template_path == "" ? local.default_path : var.config_template_path}"
}

data "template_file" "config" {
  template = "${file("${path.cwd}/${local.actual_path}")}"
  vars     = "${var.template_vars}"
  count    = "${var.is_config_managed}"
}
