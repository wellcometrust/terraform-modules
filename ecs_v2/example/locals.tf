locals {
  vpc_cidr_block     = "10.120.0.0/16"
  service_namespace  = "ecsV2"
  aws_region         = "eu-west-1"
  service_name       = "ecs_v2_test"
  security_group_ids = []
}
