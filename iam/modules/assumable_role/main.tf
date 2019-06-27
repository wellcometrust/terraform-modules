resource "aws_iam_role" "role" {
  name               = "${var.name}"
  assume_role_policy = "${local.policy}"
}

locals {
  aws = "${data.aws_iam_policy_document.assume_role_aws.json}"
  federated = "${data.aws_iam_policy_document.assume_role_federated.json}"

  policy = "${var.auth_type == "federated" ? local.federated : local.aws }"
}

data "aws_iam_policy_document" "assume_role_aws" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = "${var.principals}"
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "assume_role_federated" {
  statement {
    effect = "Allow"

    principals {
      type = "Federated"
      identifiers = "${var.principals}"
    }

    condition {
      test = "StringEquals"
      values = ["https://signin.aws.amazon.com/saml"]
      variable = "SAML:aud"
    }
  }
}