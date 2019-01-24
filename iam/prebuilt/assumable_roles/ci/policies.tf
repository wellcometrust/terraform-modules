data "aws_caller_identity" "current" {}

locals {
  account_id = "${data.aws_caller_identity.current.account_id}"
}

data "aws_iam_policy_document" "publish_to_aws" {
  statement {
    actions = [
      "ecr:PutImage",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "ssm:PutParameter",
    ]

    resources = [
      "arn:aws:ssm:eu-west-1:${local.account_id}:parameter/releases/*",
    ]
  }
}
