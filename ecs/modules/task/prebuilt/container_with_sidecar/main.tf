module "container_definition" {
  source = "../../modules/container_definition/container_with_sidecar"

  aws_region = "${var.aws_region}"

  task_name = "${var.task_name}"

  log_group_prefix = "${var.log_group_prefix}"

  app_cpu    = "${var.app_cpu}"
  app_memory = "${var.app_memory}"

  app_container_image      = "${var.app_container_image}"
  app_port_mappings_string = "${module.app_port_mappings.port_mappings_string}"
  app_env_vars             = "${var.app_env_vars}"

  sidecar_memory = "${var.sidecar_memory}"
  sidecar_cpu    = "${var.sidecar_cpu}"

  sidecar_container_image      = "${var.sidecar_container_image}"
  sidecar_port_mappings_string = "${module.sidecar_port_mappings.port_mappings_string}"
  sidecar_env_vars             = "${var.sidecar_env_vars}"

  app_env_vars_length     = "${var.app_env_vars_length}"
  sidecar_env_vars_length = "${var.sidecar_env_vars_length}"
}

module "task_definition" {
  source    = "../../modules/task_definition/default"
  task_name = "${var.task_name}"

  task_definition_rendered = "${module.container_definition.rendered}"

  launch_types = ["${var.launch_types}"]

  cpu    = "${var.cpu}"
  memory = "${var.memory}"
}

module "app_port_mappings" {
  source         = "../../modules/port_mappings"
  container_port = "${var.app_container_port}"
}

module "sidecar_port_mappings" {
  source         = "../../modules/port_mappings"
  container_port = "${var.sidecar_container_port}"
}
