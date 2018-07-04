locals {
  vpc_cidr_block = "10.120.0.0/16"
  namespace      = "ecsV2"
  aws_region     = "eu-west-1"
}

resource "aws_ecs_cluster" "cluster" {
  name = "ecsV2"
}

module "network" {
  source     = "../../network"
  name       = "ecsV2"
  cidr_block = "${local.vpc_cidr_block}"
  az_count   = "2"
}

resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name = "${local.namespace}"
  vpc  = "${module.network.vpc_id}"
}

module "task" {
  source = "../modules/task/prebuilt/single_container"

  aws_region = "${local.aws_region}"
  task_name  = "${local.namespace}"

  container_image = "strm/helloworld-http"
  container_port  = "80"
}

module "task_with_sidecar" {
  source = "../modules/task/prebuilt/container_with_sidecar"

  aws_region = "${local.aws_region}"
  task_name  = "${local.namespace}_with_sidecar"

  memory = "2048"
  cpu    = "1024"

  app_container_image = "strm/helloworld-http"
  app_container_port  = "80"

  app_cpu    = "512"
  app_memory = "1024"

  sidecar_container_image = "memcached"
  sidecar_container_port  = "11211"

  sidecar_cpu    = "512"
  sidecar_memory = "1024"
}

# Fargate service - public

module "ecs_fargate_public" {
  source = "../modules/service/prebuilt/load_balanced"

  service_name       = "${local.namespace}_with_lb"
  task_desired_count = "1"

  task_definition_arn = "${module.task.task_definition_arn}"

  security_group_ids = ["${aws_security_group.interservice_security_group.id}", "${aws_security_group.service_lb_security_group.id}", "${aws_security_group.service_egress_security_group.id}"]

  container_name = "${module.task.task_name}"
  container_port = "80"

  ecs_cluster_id = "${aws_ecs_cluster.cluster.id}"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  namespace_id     = "${aws_service_discovery_private_dns_namespace.namespace.id}"
  healthcheck_path = "/"

  launch_type = "FARGATE"
}

# Fargate service - public - with sidecar

module "ecs_fargate_public_with_sidecar" {
  source = "../modules/service/prebuilt/load_balanced"

  service_name       = "${local.namespace}_with_lb_with_sidecar"
  task_desired_count = "1"

  task_definition_arn = "${module.task_with_sidecar.task_definition_arn}"

  security_group_ids = ["${aws_security_group.interservice_security_group.id}", "${aws_security_group.service_egress_security_group.id}", "${aws_security_group.service_lb_security_group.id}", "${aws_security_group.service_egress_security_group.id}"]

  container_name = "${module.task_with_sidecar.app_task_name}"
  container_port = "80"

  ecs_cluster_id = "${aws_ecs_cluster.cluster.id}"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  namespace_id     = "${aws_service_discovery_private_dns_namespace.namespace.id}"
  healthcheck_path = "/"

  launch_type = "EC2"
}

# Fargate service - private

module "ecs_fargate_private" {
  source = "../modules/service/prebuilt/default"

  service_name       = "${local.namespace}_fargate_private"
  task_desired_count = "1"

  task_definition_arn = "${module.task.task_definition_arn}"

  security_group_ids = ["${aws_security_group.interservice_security_group.id}", "${aws_security_group.service_egress_security_group.id}"]

  container_port = "${module.task.task_port}"

  ecs_cluster_id = "${aws_ecs_cluster.cluster.id}"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  launch_type = "FARGATE"
}

# EC2 service - public

module "ecs_ec2_public" {
  source = "../modules/service/prebuilt/load_balanced"

  service_name       = "${local.namespace}_ec2_public"
  task_desired_count = "1"

  task_definition_arn = "${module.task.task_definition_arn}"

  security_group_ids = ["${aws_security_group.interservice_security_group.id}", "${aws_security_group.service_lb_security_group.id}", "${aws_security_group.service_egress_security_group.id}"]

  container_name = "${module.task.task_name}"
  container_port = "${module.task.task_port}"

  ecs_cluster_id = "${aws_ecs_cluster.cluster.id}"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  namespace_id     = "${aws_service_discovery_private_dns_namespace.namespace.id}"
  healthcheck_path = "/"

  launch_type = "EC2"
}

# EC2 service - private

module "ecs_ec2_private" {
  source = "../modules/service/prebuilt/default"

  service_name       = "${local.namespace}_ec2_private"
  task_desired_count = "1"

  task_definition_arn = "${module.task.task_definition_arn}"

  security_group_ids = ["${aws_security_group.interservice_security_group.id}", "${aws_security_group.service_egress_security_group.id}"]

  container_port = "${module.task.task_port}"

  ecs_cluster_id = "${aws_ecs_cluster.cluster.id}"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  launch_type = "EC2"
}

# EC2 service - private - ebs

module "ebs_task" {
  source = "../modules/task/prebuilt/single_container+ebs"

  aws_region = "${local.aws_region}"
  task_name  = "${local.namespace}_ec2_private_ebs"

  container_image = "strm/helloworld-http"
  container_port  = "80"

  ebs_host_path      = "${module.ec2_ebs_host.ebs_host_path}"
  ebs_container_path = "/ebs"
}

module "ecs_ec2_private_ebs" {
  source = "../modules/service/prebuilt/default"

  service_name       = "${local.namespace}_ec2_private_ebs"
  task_desired_count = "1"

  task_definition_arn = "${module.ebs_task.task_definition_arn}"

  security_group_ids = ["${aws_security_group.interservice_security_group.id}", "${aws_security_group.service_egress_security_group.id}"]

  container_port = "${module.task.task_port}"

  ecs_cluster_id = "${aws_ecs_cluster.cluster.id}"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  launch_type = "EC2"
}

# EC2 service - private - efs

module "efs_task" {
  source = "../modules/task/prebuilt/single_container+efs"

  aws_region = "${local.aws_region}"
  task_name  = "${local.namespace}_ec2_private_efs"

  container_image = "strm/helloworld-http"
  container_port  = "80"

  efs_host_path      = "${module.ec2_efs_host.efs_host_path}"
  efs_container_path = "/efs"
}

module "ecs_ec2_private_efs" {
  source = "../modules/service/prebuilt/default"

  service_name       = "${local.namespace}_ec2_private_efs"
  task_desired_count = "1"

  task_definition_arn = "${module.efs_task.task_definition_arn}"

  security_group_ids = ["${aws_security_group.interservice_security_group.id}", "${aws_security_group.service_egress_security_group.id}"]

  container_port = "${module.efs_task.task_port}"

  ecs_cluster_id = "${aws_ecs_cluster.cluster.id}"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  launch_type = "EC2"
}

# EC2 service - private - ebs+efs

module "ebs_efs_task" {
  source = "../modules/task/prebuilt/single_container+ebs+efs"

  aws_region = "${local.aws_region}"
  task_name  = "${local.namespace}_ec2_private_ebs_efs"

  container_image = "strm/helloworld-http"
  container_port  = "80"

  efs_host_path      = "${module.ec2_ebs_efs_host.efs_host_path}"
  efs_container_path = "/efs"

  ebs_host_path      = "${module.ec2_ebs_efs_host.ebs_host_path}"
  ebs_container_path = "/ebs"
}

module "ecs_ec2_private_ebs_efs" {
  source = "../modules/service/prebuilt/default"

  service_name       = "${local.namespace}_ec2_private_ebs_efs"
  task_desired_count = "1"

  task_definition_arn = "${module.ebs_efs_task.task_definition_arn}"

  security_group_ids = ["${aws_security_group.interservice_security_group.id}", "${aws_security_group.service_egress_security_group.id}"]

  container_port = "${module.ebs_efs_task.task_port}"

  ecs_cluster_id = "${aws_ecs_cluster.cluster.id}"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  launch_type = "EC2"
}

# Fargate SQS Autoscaling service

module "alarm_topic" {
  source = "../../sns"
  name   = "${local.namespace}_ecs_fargate_sqs_scaling_alarm_topic"
}

module "topic" {
  source = "../../sns"
  name   = "${local.namespace}_ecs_fargate_sqs_scaling_topic"
}

module "queue" {
  source = "../../sqs"

  queue_name = "${local.namespace}_ecs_fargate_sqs_scaling_queue"

  alarm_topic_arn = "${module.alarm_topic.arn}"
  topic_names     = ["${module.topic.name}"]

  account_id = "${data.aws_caller_identity.current.account_id}"

  aws_region = "${local.aws_region}"
}

module "ecs_fargate_sqs_scaling" {
  source = "../modules/service/prebuilt/sqs_scaling"

  service_name       = "${local.namespace}_ecs_fargate_sqs_scaling"
  task_desired_count = "1"

  container_image = "strm/helloworld-http"

  security_group_ids = ["${aws_security_group.interservice_security_group.id}", "${aws_security_group.service_egress_security_group.id}"]

  source_queue_name = "${module.queue.name}"
  source_queue_arn  = "${module.queue.arn}"

  ecs_cluster_id   = "${aws_ecs_cluster.cluster.id}"
  ecs_cluster_name = "${aws_ecs_cluster.cluster.name}"

  aws_region = "${local.aws_region}"
  vpc_id     = "${module.network.vpc_id}"
  subnets    = "${module.network.private_subnets}"

  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  launch_type = "FARGATE"
}
