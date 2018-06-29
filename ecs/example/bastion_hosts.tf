# EC2 Bastion hosts

module "ec2_bastion" {
  source = "../../ec2/prebuilt/bastion"

  vpc_id = "${module.network.vpc_id}"

  name = "ecsV2-bastion-host"

  controlled_access_cidr_ingress = ["195.143.129.128/25"]

  key_name    = "wellcomedigitalplatform"
  subnet_list = "${module.network.public_subnets}"
}
