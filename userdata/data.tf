data "template_file" "template" {
  template = "${file("${path.module}/templates/${data.template_file.userdata_template_name.rendered}.yml.template")}"

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

data "template_file" "userdata_template_name" {
  template = "ecs-agent$${ebs_suffix}$${efs_suffix}"

  vars {
    ebs_suffix = "${local.has_ebs_mount == true ? "-with-ebs" : ""}"
    efs_suffix = "${local.has_efs_mount == true ? "-with-efs" : ""}"
  }
}

locals {
  has_efs_mount   = "${var.efs_filesystem_id == "" ? false :true}"
  has_ebs_mount   = "${var.ebs_block_device == "" ? false :true}"
  efs_mount_directory = "${local.has_efs_mount == true ? "/mnt/efs": ""}"
  ebs_mount_directory = "${local.has_ebs_mount == true ?"/mnt/ebs" : ""}"
  mount_directories = ["${local.efs_mount_directory}", "${local.ebs_mount_directory}"]
}
