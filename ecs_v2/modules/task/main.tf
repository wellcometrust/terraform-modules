resource "aws_ecs_task_definition" "task" {
  family                = "${var.task_name}"
  container_definitions = "${element(concat(data.template_file.custom_definition.*.rendered, data.template_file.definition.*.rendered), 0)}"

  task_role_arn      = "${local.task_role_arn}"
  execution_role_arn = "${local.execution_role_arn}"

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "${var.cpu}"
  memory = "${var.memory}"
}

module "iam_role" {
  source = "iam_role"
  name   = "${var.task_name}"
}
