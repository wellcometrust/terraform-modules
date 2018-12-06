module "iam_roles" {
  source = "../../iam_roles"

  task_name = "${var.task_name}"
}

locals {
  nvm_volume_name = "nvm"

  mount_points = [
    {
      sourceVolume  = "${local.nvm_volume_name}"
      containerPath = "${var.nvm_container_path}"
    },
  ]
}

resource "aws_ecs_task_definition" "task" {
  family                = "${var.task_name}"
  container_definitions = "${var.task_definition_rendered}"

  task_role_arn      = "${module.iam_roles.task_role_arn}"
  execution_role_arn = "${module.iam_roles.task_execution_role_arn}"

  network_mode = "awsvpc"

  # For now, using nvm/EFS means we need to be on EC2 instance.
  requires_compatibilities = ["EC2"]

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  volume {
    name      = "${local.nvm_volume_name}"
    host_path = "${var.nvm_host_path}"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:nvm.volume exists"
  }
}
