# This gives permissions for the execution role to read the necessary
# parameters and secrets from SSM and KMS.

data "aws_caller_identity" "current" {}

locals {
  ssm_arn_prefix     = "arn:aws:ssm:eu-west-1:${data.aws_caller_identity.current.account_id}:parameter/aws/reference/secretsmanager"
  secrets_arn_prefix = "arn:aws:secretsmanager:eu-west-1:${data.aws_caller_identity.current.account_id}:secret"

  # These locals construct a list of ARNs for the SSM and SecretsManager
  # resources associated with our secret environment variables.
  #
  # This allows us to scope the execution role so each app can only read
  # the secrets that it actually uses.
  #
  ssm_resources     = "${formatlist("${local.ssm_arn_prefix}/%s", "${values(var.secret_env_vars)}")}"
  secrets_resources = "${formatlist("${local.secrets_arn_prefix}:%s*", "${values(var.secret_env_vars)}")}"
}

data "aws_iam_policy_document" "read_secrets" {
  statement {
    actions = [
      "ssm:GetParameters",
    ]

    resources = ["${local.ssm_resources}"]
  }

  statement {
    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = ["${local.secrets_resources}"]
  }
}

resource "aws_iam_role_policy" "allow_read_secrets" {
  # If there aren't any environment variables, the policy document will be
  # empty and we can skip creating the policy.
  count = "${var.secret_env_vars_length > 0 ? 1 : 0}"

  role   = "${var.execution_role_name}"
  policy = "${data.aws_iam_policy_document.read_secrets.json}"
}
