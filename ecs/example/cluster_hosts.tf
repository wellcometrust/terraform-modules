# EC2 Cluster hosts - ondemand

module "ec2_hosts_ondemand" {
  source = "../modules/ec2/prebuilt/ondemand"

  cluster_name = "${aws_ecs_cluster.cluster.name}"
  vpc_id       = "${module.network.vpc_id}"

  asg_name                    = "ecsV2-ondemand"
  ssh_ingress_security_groups = ["${module.ec2_bastion.ssh_controlled_ingress_sg}"]

  subnets  = "${module.network.private_subnets}"
  key_name = "wellcomedigitalplatform"

  instance_type = "t2.large"
  asg_desired   = "2"
}

# EC2 Cluster hosts - spot

module "ec2_host_spot" {
  source = "../modules/ec2/prebuilt/spot"

  cluster_name = "${aws_ecs_cluster.cluster.name}"
  vpc_id       = "${module.network.vpc_id}"

  asg_name                    = "ecsV2-spot"
  ssh_ingress_security_groups = ["${module.ec2_bastion.ssh_controlled_ingress_sg}"]

  subnets  = "${module.network.private_subnets}"
  key_name = "wellcomedigitalplatform"

  spot_price = "0.5"
}

# EC2 Cluster hosts - ebs

module "ec2_ebs_host" {
  source = "../modules/ec2/prebuilt/ebs"

  cluster_name = "${aws_ecs_cluster.cluster.name}"
  vpc_id       = "${module.network.vpc_id}"

  asg_name                    = "ecsV2-ebs"
  ssh_ingress_security_groups = ["${module.ec2_bastion.ssh_controlled_ingress_sg}"]

  subnets  = "${module.network.private_subnets}"
  key_name = "wellcomedigitalplatform"
}

# EC2 Cluster hosts - efs

module "efs" {
  source = "../../efs"

  name = "ecsV2"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  efs_access_security_group_ids = ["${aws_security_group.efs_security_group.id}"]
}

module "ec2_efs_host" {
  source = "../modules/ec2/prebuilt/efs"

  cluster_name = "${aws_ecs_cluster.cluster.name}"
  vpc_id       = "${module.network.vpc_id}"

  asg_name = "ecsV2-efs"

  ssh_ingress_security_groups = ["${module.ec2_bastion.ssh_controlled_ingress_sg}"]
  custom_security_groups      = ["${aws_security_group.efs_security_group.id}"]

  subnets  = "${module.network.private_subnets}"
  key_name = "wellcomedigitalplatform"

  efs_fs_id = "${module.efs.efs_id}"
  region    = "${local.aws_region}"
}

# EC2 Cluster hosts - ebs+efs

module "ec2_ebs_efs_host" {
  source = "../modules/ec2/prebuilt/ebs+efs"

  cluster_name = "${aws_ecs_cluster.cluster.name}"
  vpc_id       = "${module.network.vpc_id}"

  asg_name = "ecsV2-ebs-efs"

  ssh_ingress_security_groups = ["${module.ec2_bastion.ssh_controlled_ingress_sg}"]
  custom_security_groups      = ["${aws_security_group.efs_security_group.id}"]

  subnets  = "${module.network.private_subnets}"
  key_name = "wellcomedigitalplatform"

  efs_fs_id = "${module.efs.efs_id}"
  region    = "${local.aws_region}"

  asg_desired = "2"
}
