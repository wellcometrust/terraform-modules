data "template_file" "config" {
  template = "${file("${path.cwd}/${var.config_template_path == "" ? var.config_template_path : templates/${var.app_name}.ini.template}")}"
  vars     = "${var.template_vars}"
  count    = "${var.is_config_managed}"
}
