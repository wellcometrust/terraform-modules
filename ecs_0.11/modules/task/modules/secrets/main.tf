data "template_file" "name_val_pair" {
  # This module constructs a JSON string in the same way as the `env_vars`
  # module, and has the same issue that requires us to pass the length of
  # the env_vars map as a variable.
  count = "${var.secret_env_vars_length}"

  template = <<EOF
  {
    "name": $${jsonencode(key)},
    "valueFrom": $${jsonencode(value)}
  }
EOF

  vars = {
    key = "${element(keys(var.secret_env_vars), count.index)}"

    # This prefix allows us to access a SecretsManager secret via SSM.
    # See https://docs.aws.amazon.com/systems-manager/latest/userguide/integration-ps-secretsmanager.html
    value = "/aws/reference/secretsmanager/${element(values(var.secret_env_vars), count.index)}"
  }
}

locals {
  env_var_string = "[${join(", ", "${data.template_file.name_val_pair.*.rendered}")}]"
}
