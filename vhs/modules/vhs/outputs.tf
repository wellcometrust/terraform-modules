output "dynamodb_update_policy" {
  value = "${module.dynamo.dynamodb_update_policy}"
}

output "bucket_name" {
  value = "${aws_s3_bucket.bucket.id}"
}

output "read_policy" {
  value = "${data.aws_iam_policy_document.read_policy.json}"
}

output "full_access_policy" {
  value = "${data.aws_iam_policy_document.full_access_policy.json}"
}

output "table_name" {
  value = "${module.dynamo.table_name}"
}

output "table_arn" {
  value = "${module.dynamo.table_arn}"
}

output "table_stream_arn" {
  value = "${module.dynamo.table_stream_arn}"
}
