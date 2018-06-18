resource "aws_ecs_cluster" "cluster" {
  name = "ecsV2"
}

module "network" {
  source     = "../modules/network"
  name       = "ecsV2"
  cidr_block = "${local.vpc_cidr_block}"
  az_count   = "2"
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

module "ec2_hosts" {
  source = "../modules/ec2"

  cluster_name = "${aws_ecs_cluster.cluster.name}"
  vpc_id = "${module.network.vpc_id}"

  subnets = "${module.network.private_subnets}"
  key_name = "wellcomedigitalplatform"
}
