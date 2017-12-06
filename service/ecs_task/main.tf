resource "aws_ecs_task_definition" "task" {
  family                = "${var.name}_task_definition"
  container_definitions = "${data.template_file.definition.rendered}"
  task_role_arn         = "${local.task_role_arn}"

  volume {
    name      = "${var.volume_name}"
    host_path = "${var.volume_host_path}"
  }
}

module "iam_role" {
  source = "iam_role"
  name   = "${var.name}"
}
