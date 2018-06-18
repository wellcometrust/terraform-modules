resource "aws_ecs_cluster" "cluster" {
  name = "ecsV2"
}

module "network" {
  source     = "../modules/network"
  name       = "ecsV2"
  cidr_block = "${local.vpc_cidr_block}"
  az_count   = "2"
}

resource "aws_security_group" "security_group" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${module.network.vpc_id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    self      = true
    security_groups = ["${local.security_group_ids}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${local.service_namespace}"
  }
}

resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name = "${local.service_namespace}"
  vpc  = "${module.network.vpc_id}"
}

module "task" {
  source = "../modules/task"

  aws_region = "${local.aws_region}"
  task_name  = "${local.service_name}"
  container_image = "strm/helloworld-http"
}

# Fargate service

module "ecs_fargate" {
  source = "../modules/service"

  service_name       = "${local.service_name}_1"
  task_desired_count = "1"

  task_definition_arn = "${module.task.arn}"

  security_group_ids = ["${aws_security_group.security_group.id}"]

  container_name = "${module.task.container_name}"
  container_port = "${module.task.container_port}"

  ecs_cluster_id = "${aws_ecs_cluster.cluster.id}"

  vpc_id         = "${module.network.vpc_id}"
  vpc_cidr_block = "${local.vpc_cidr_block}"
  subnets        = "${module.network.private_subnets}"

  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  launch_type = "FARGATE"
}

# EC2 service

module "ecs_ec2" {
  source = "../modules/service"

  service_name       = "${local.service_name}_2"
  task_desired_count = "1"

  task_definition_arn = "${module.task.arn}"

  container_name = "${module.task.container_name}"
  container_port = "${module.task.container_port}"

  ecs_cluster_id = "${aws_ecs_cluster.cluster.id}"

  vpc_id         = "${module.network.vpc_id}"
  vpc_cidr_block = "${local.vpc_cidr_block}"
  subnets        = "${module.network.private_subnets}"

  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  launch_type = "EC2"
}

# EC2 Cluster hosts

module "ec2_hosts_public" {
  source = "../modules/ec2"

  cluster_name = "${aws_ecs_cluster.cluster.name}"
  vpc_id = "${module.network.vpc_id}"

  asg_name = "ecsV2public"
  controlled_access_cidr_ingress = ["83.244.194.128/25"]

  subnets = "${module.network.public_subnets}"
  key_name = "wellcomedigitalplatform"
}

module "ec2_host_private" {
  source = "../modules/ec2"

  cluster_name = "${aws_ecs_cluster.cluster.name}"
  vpc_id = "${module.network.vpc_id}"

  asg_name = "ecsV2private"
  instance_security_groups = ["${module.ec2_hosts_public.ssh_controlled_ingress_sg}"]

  subnets = "${module.network.private_subnets}"
  key_name = "wellcomedigitalplatform"
}
