module "alb_target_500_errors" {
  enable_alarm = "${var.enable_alb_alarm}"

  source = "./alb_alarm"
  name   = "${var.service_name}-alb-target-500-errors"

  metric    = "HTTPCode_Target_5XX_Count"
  topic_arn = "${var.server_error_alarm_topic_arn}"

  tg_dimension = "${aws_alb_target_group.ecs_service.arn_suffix}"
  lb_dimension = "${var.loadbalancer_cloudwatch_id}"
}

module "alb_target_400_errors" {
  enable_alarm = "${var.enable_alb_alarm}"

  source = "./alb_alarm"
  name   = "${var.service_name}-alb-target-400-errors"

  metric    = "HTTPCode_Target_4XX_Count"
  topic_arn = "${var.client_error_alarm_topic_arn}"

  tg_dimension = "${aws_alb_target_group.ecs_service.arn_suffix}"
  lb_dimension = "${var.loadbalancer_cloudwatch_id}"
}

module "unhealthy_hosts_alarm" {
  enable_alarm = "${var.enable_alb_alarm}"

  source = "./alb_alarm"
  name   = "${var.service_name}-alb-unhealthy-hosts"

  metric    = "UnHealthyHostCount"
  topic_arn = "${var.client_error_alarm_topic_arn}"

  dimensions = {
    LoadBalancer = "${var.loadbalancer_cloudwatch_id}"
    TargetGroup  = "${aws_alb_target_group.ecs_service.arn_suffix}"
  }
}

