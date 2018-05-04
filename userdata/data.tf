data "template_file" "template" {
  template = "${file("${path.module}/templates/${local.template_name}.yml.template")}"

  vars {
    aws_region                   = "${var.aws_region}"
    ecs_cluster_name             = "${var.cluster_name}"
    ecs_log_level                = "info"
    ecs_agent_version            = "latest"
    ecs_log_group_name           = "${aws_cloudwatch_log_group.ecs_agent.name}"
    efs_filesystem_id            = "${var.efs_filesystem_id}"
    efs_mount_directory          = "${local.efs_mount_directory}"
    ebs_block_device             = "${var.ebs_block_device}"
    ebs_cache_cleaner_group_name = "${var.cache_cleaner_cloudwatch_log_group}"
    ebs_cache_max_age_days       = "${var.ebs_cache_max_age_days}"
    ebs_cache_max_size           = "${var.ebs_cache_max_size}"
  }
}

locals {
  has_efs_mount   = "${var.efs_filesystem_id == "no_name_set" ? false :true}"
  has_ebs_mount   = "${var.ebs_block_device == "no_name_set" ? false :true}"
  has_ebs_and_efs_mount   = "${local.has_efs_mount == true ? "${local.has_ebs_mount == true ? true: false}" :false}"
  has_no_mount    = "${local.has_efs_mount == false ? "${local.has_ebs_mount == false ? true: false}" :false}"
  template_name_no_mount   = "ecs-agent"
  template_name_ebs   = "${local.template_name_no_mount}${local.has_ebs_mount == true ? "-with-ebs" : ""}"
  template_name   = "${local.template_name_ebs}${local.has_efs_mount == true ?"-with-efs": ""}"
  efs_mount_directory = "${local.has_efs_mount == true ? "/mnt/efs": ""}"
  ebs_mount_directory = "${local.has_ebs_mount == true ?"/mnt/ebs" : ""}"
  mount_directories = ["${local.efs_mount_directory}", "${local.ebs_mount_directory}"]
}
