data "aws_ecs_cluster" "host_cluster" {
  cluster_name = "${var.cluster_name}"
}

data "aws_caller_identity" "current" {}
