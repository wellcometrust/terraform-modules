module "log_group" {
  source = "../../modules/log_group"

  task_name = "${var.task_name}"
}

module "iam_roles" {
  source = "../../modules/iam_roles"

  task_name = "${var.task_name}"
}

module "env_vars" {
  source = "../../modules/env_vars"

  env_vars = "${var.env_vars}"
}

module "task_definition" {
  source = "../../modules/task_definition"

  log_group_name = "${module.log_group.name}"
  env_var_string = "${module.env_vars.env_vars_string}"

  container_image = "${var.container_image}"
  container_name  = "${var.container_name}"
  container_port  = "${var.container_port}"

  aws_region = "${var.aws_region}"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  mount_points = "${local.mount_points}"
}

locals {
  ebs_volume_name = "ebs"

  mount_points = [
    {
      sourceVolume  = "${local.ebs_volume_name}"
      containerPath = "${var.ebs_container_path}"
    },
  ]
}

resource "aws_ecs_task_definition" "task" {
  family                = "${var.task_name}"
  container_definitions = "${module.task_definition.rendered}"

  task_role_arn      = "${module.iam_roles.task_role_arn}"
  execution_role_arn = "${module.iam_roles.task_execution_role_arn}"

  network_mode             = "awsvpc"

  # For now, using EBS/EFS means we need to be on EC2 instance.
  requires_compatibilities = ["EC2"]

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  volume {
    name      = "${local.ebs_volume_name}"
    host_path = "${var.ebs_host_path}"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ebs.volume exists"
  }
}
