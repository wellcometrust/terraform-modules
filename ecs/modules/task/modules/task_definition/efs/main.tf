module "iam_roles" {
  source = "../../iam_roles"

  task_name = "${var.task_name}"
}

locals {
  efs_volume_name = "efs"

  mount_points = [
    {
      sourceVolume  = "${local.efs_volume_name}"
      containerPath = "${var.efs_container_path}"
    },
  ]
}

resource "aws_ecs_task_definition" "task" {
  family                = "${var.task_name}"
  container_definitions = "${var.task_definition_rendered}"

  task_role_arn      = "${module.iam_roles.task_role_arn}"
  execution_role_arn = "${module.iam_roles.task_execution_role_arn}"

  network_mode = "awsvpc"

  # For now, using EBS/EFS means we need to be on EC2 instance.
  requires_compatibilities = ["EC2"]

  volume {
    name      = "${local.efs_volume_name}"
    host_path = "${var.efs_host_path}"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:efs.volume exists"
  }

  cpu    = "${var.cpu}"
  memory = "${var.memory}"
}
