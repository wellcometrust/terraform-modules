module "cluster_userdata" {
  source            = "git::https://github.com/wellcometrust/terraform.git//userdata?ref=v1.0.0"
  cluster_name      = "${aws_ecs_cluster.cluster.name}"
  efs_filesystem_id = "${var.efs_filesystem_id}"
}
