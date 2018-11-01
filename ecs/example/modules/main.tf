# Fargate service

module "ecs_fargate" {
  source = "../../modules/service/prebuilt/default"

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

# EC2 service

module "ecs_ec2" {
  source = "../../modules/service/prebuilt/default"

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

# EC2 service - ebs

module "ebs_task" {
  source = "../../modules/task/prebuilt/single_container+ebs"

  aws_region = "${local.aws_region}"
  task_name  = "${local.namespace}_ec2_private_ebs"

  container_image = "strm/helloworld-http"
  container_port  = "80"

  ebs_host_path      = "${module.ec2_ebs_host.ebs_host_path}"
  ebs_container_path = "/ebs"
}

module "ecs_ec2_ebs" {
  source = "../../modules/service/prebuilt/default"

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

# EC2 service - efs

module "efs_task" {
  source = "../../modules/task/prebuilt/single_container+efs"

  aws_region = "${local.aws_region}"
  task_name  = "${local.namespace}_ec2_private_efs"

  container_image = "strm/helloworld-http"
  container_port  = "80"

  efs_host_path      = "${module.ec2_efs_host.efs_host_path}"
  efs_container_path = "/efs"
}

module "ecs_ec2_efs" {
  source = "../../modules/service/prebuilt/default"

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

# EC2 service - ebs+efs

module "ebs_efs_task" {
  source = "../../modules/task/prebuilt/single_container+ebs+efs"

  aws_region = "${local.aws_region}"
  task_name  = "${local.namespace}_ec2_private_ebs_efs"

  container_image = "strm/helloworld-http"
  container_port  = "80"

  efs_host_path      = "${module.ec2_ebs_efs_host.efs_host_path}"
  efs_container_path = "/efs"

  ebs_host_path      = "${module.ec2_ebs_efs_host.ebs_host_path}"
  ebs_container_path = "/ebs"
}

module "ecs_ec2_ebs_efs" {
  source = "../../modules/service/prebuilt/default"

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
