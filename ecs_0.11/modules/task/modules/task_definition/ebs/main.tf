module "iam_roles" {
  source = "../../iam_roles"

  task_name = "${var.task_name}"
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
  container_definitions = "${var.task_definition_rendered}"

  task_role_arn      = "${module.iam_roles.task_role_arn}"
  execution_role_arn = "${module.iam_roles.task_execution_role_arn}"

  network_mode = "awsvpc"

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
