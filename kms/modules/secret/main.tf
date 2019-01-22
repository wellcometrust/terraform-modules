locals {
  prefix = "/aws/reference/secretsmanager"
}

resource "aws_secretsmanager_secret" "secret" {
  name       = "${var.name}"
  kms_key_id = "${var.kms_key_id}"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = "${aws_secretsmanager_secret.secret.id}"
  secret_string = "_"

  lifecycle {
    ignore_changes = ["secret_string"]
  }
}

data "aws_ssm_parameter" "param" {
  name = "${local.prefix}/${aws_secretsmanager_secret.secret.name}"

  depends_on = [
    "aws_secretsmanager_secret.secret",
    "aws_secretsmanager_secret_version.secret_version",
  ]
}
