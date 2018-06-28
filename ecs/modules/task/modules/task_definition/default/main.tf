module "iam_roles" {
  source = "../../iam_roles"

  task_name = "${var.task_name}"
}

resource "aws_ecs_task_definition" "task" {
  family                = "${var.task_name}"
  container_definitions = "${var.task_definition_rendered}"

  task_role_arn      = "${module.iam_roles.task_role_arn}"
  execution_role_arn = "${module.iam_roles.task_execution_role_arn}"

  network_mode             = "awsvpc"
  requires_compatibilities = ["${var.launch_types}"]

  cpu    = "${var.cpu}"
  memory = "${var.memory}"
}
