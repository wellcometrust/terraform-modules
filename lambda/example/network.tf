locals {
  vpc_cidr_block = "10.33.0.0/16"
  namespace      = "lambdaV2"
  aws_region     = "eu-west-1"
}

module "network" {
  source     = "../../network"
  name       = "lambdaV2"
  cidr_block = "${local.vpc_cidr_block}"
  az_count   = "1"
}