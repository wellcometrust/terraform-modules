data "template_file" "name_val_pair" {
  // TODO: This module has the same issue as env_vars
  // with requiring the env_vars_length to be passed in
  count = "${var.env_vars_length}"

  template = "{\"name\": $${jsonencode(key)}, \"valueFrom\": $${jsonencode(value)}}"

  vars {
    key   = "${element(keys(var.env_vars), count.index)}"
    value = "${element(values(var.env_vars), count.index)}"
  }
}

locals {
  env_var_string = "[${join(", ", "${data.template_file.name_val_pair.*.rendered}")}]"
}
