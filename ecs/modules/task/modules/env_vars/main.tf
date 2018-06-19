data "template_file" "name_val_pair" {
  count    = "${length(var.env_vars)}"
  template = "{\"name\": $${jsonencode(key)}, \"value\": $${jsonencode(value)}}"

  vars {
    key   = "${element(keys(var.env_vars), count.index)}"
    value = "${element(values(var.env_vars), count.index)}"
  }
}

locals {
  env_var_string = "[${join(", ", "${data.template_file.name_val_pair.*.rendered}")}]"
}
