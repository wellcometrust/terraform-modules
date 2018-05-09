module "cluster_userdata" {
  source            = "git::https://github.com/wellcometrust/terraform.git//userdata"
  cluster_name      = "${aws_ecs_cluster.cluster.name}"
  efs_filesystem_id = "${var.efs_filesystem_id}"
  ebs_block_device = "${var.ebs_device_name}"
  log_retention_in_days = "${var.log_retention_in_days}"
}
