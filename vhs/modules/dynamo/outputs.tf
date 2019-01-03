output "table_stream_arn" {
  value = "${aws_dynamodb_table.table.stream_arn}"
}

output "table_name" {
  value = "${aws_dynamodb_table.table.name}"
}

output "table_arn" {
  value = "${aws_dynamodb_table.table.arn}"
}

output "dynamodb_update_policy" {
  value = "${data.aws_iam_policy_document.dynamodb_update_policy.json}"
}
