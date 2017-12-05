module "ecs_worker_service_iam" {
  source = "git::https://github.com/wellcometrust/terraform.git//ecs_iam?ref=v1.0.0"
  name   = "id_minter"
}

resource "aws_iam_role_policy" "ecs_worker_service_task_sns" {
  name   = "ecs_task_task_sns_policy"
  role   = "${module.ecs_worker_service_iam.task_role_name}"
  policy = "${data.aws_iam_policy_document.publish_to_topic.json}"
}

resource "aws_iam_role_policy" "ecs_worker_service_task_read_id_minter_q" {
  name   = "ecs_task_worker_service_policy"
  role   = "${module.ecs_worker_service_iam.task_role_name}"
  policy = "${module.worker_service_ingest_queue.read_policy}"
}

resource "aws_iam_role_policy" "worker_service_cloudwatch" {
  role   = "${module.ecs_worker_service_iam.task_role_name}"
  policy = "${data.aws_iam_policy_document.allow_cloudwatch_push_metrics.json}"
}

data "aws_iam_policy_document" "allow_cloudwatch_push_metrics" {
  statement {
    actions = [
      "cloudwatch:PutMetricData",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "publish_to_topic" {
  statement {
    actions = [
      "sns:Publish",
    ]

    resources = [
      "${aws_sns_topic.worker_service_export_topic.arn}",
    ]
  }
}
