module "public-private-vpc" {
  source = "../prebuilt/vpc/public-private-igw"

  name = "example-private-vpc"

  cidr_block_vpc = "172.17.0.0/24"

  cidr_block_public         = "172.17.0.0/25"
  cidrsubnet_newbits_public = "3"

  cidr_block_private         = "172.17.0.128/25"
  cidrsubnet_newbits_private = "3"
}
