module "network" {
  source     = "../../network"
  name       = "lambdaV2"
  cidr_block = "${local.vpc_cidr_block}"
  az_count   = "1"
}