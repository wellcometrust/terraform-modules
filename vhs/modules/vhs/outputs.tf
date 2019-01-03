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
