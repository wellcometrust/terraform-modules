resource "aws_cloudwatch_log_group" "ecs_agent" {
  name = "${var.log_group_name_prefix}/ecs-agent-${var.cluster_name}"
}
