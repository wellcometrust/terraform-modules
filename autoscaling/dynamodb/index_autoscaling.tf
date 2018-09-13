locals {
  enable_index_read_scaling  = "${var.enable_read_scaling && var.index_name != ""? 1 : 0}"
  enable_index_write_scaling = "${var.enable_write_scaling && var.index_name != ""? 1 : 0}"
}

resource "aws_appautoscaling_target" "dynamodb_index_read_target" {
  count              = "${local.enable_index_read_scaling}"
  max_capacity       = "${var.read_max_capacity}"
  min_capacity       = "${var.read_min_capacity}"
  resource_id        = "table/${var.table_name}/index/${var.index_name}"
  scalable_dimension = "dynamodb:index:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_index_read_policy" {
  count              = "${local.enable_index_read_scaling}"
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_index_read_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "${aws_appautoscaling_target.dynamodb_index_read_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.dynamodb_index_read_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.dynamodb_index_read_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = "${var.read_target_utilization}"
  }
}

resource "aws_appautoscaling_target" "dynamodb_index_write_target" {
  count              = "${local.enable_index_write_scaling}"
  max_capacity       = "${var.write_max_capacity}"
  min_capacity       = "${var.write_min_capacity}"
  resource_id        = "table/${var.table_name}/index/${var.index_name}"
  scalable_dimension = "dynamodb:index:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_index_write_policy" {
  count              = "${local.enable_index_write_scaling}"
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.dynamodb_index_write_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "${aws_appautoscaling_target.dynamodb_index_write_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.dynamodb_index_write_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.dynamodb_index_write_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = "${var.write_target_utilization}"
  }
}
