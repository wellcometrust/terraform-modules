locals {
  default_path = "templates/${var.app_name}.ini.template"
  actual_path  = "${var.config_template_path == "" ? var.config_template_path : locals.default_path}"
}

data "template_file" "config" {
  template = "${file("${path.cwd}/${locals.actual_path}")}"
  vars     = "${var.template_vars}"
  count    = "${var.is_config_managed}"
}
