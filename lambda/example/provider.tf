# Specify the provider and access details
provider "aws" {
  region = "${local.aws_region}"

  version = "1.42.0"
}

data "aws_caller_identity" "current" {}
