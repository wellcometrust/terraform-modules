module "container_definition" {
  source = "../../modules/container_definition/container_with_sidecar"

  aws_region = "${var.aws_region}"

  task_name = "${var.task_name}"

  log_group_prefix = "${var.log_group_prefix}"

  app_cpu    = "${var.app_cpu}"
  app_memory = "${var.app_memory}"

  app_container_image = "${var.app_container_image}"
  app_container_port  = "${var.app_container_port}"
  app_env_vars        = "${var.app_env_vars}"
  // Only the app container gets mount points
  app_mount_points    = "${module.task_definition.mount_points}"

  sidecar_container_image = "${var.sidecar_container_image}"
  sidecar_container_port  = "${var.sidecar_container_port}"

  sidecar_memory = "${var.sidecar_memory}"
  sidecar_cpu    = "${var.sidecar_cpu}"
  sidecar_env_vars = "${var.sidecar_env_vars}"
}

module "task_definition" {
  source = "../../modules/task_definition/efs"
  task_name = "${var.task_name}"

  task_definition_rendered = "${module.container_definition.rendered}"

  efs_container_path = "${var.efs_container_path}"
  efs_host_path      = "${var.efs_host_path}"
}