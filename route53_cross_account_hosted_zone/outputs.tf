output "aws_iam_role_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "aws_iam_role_uid" {
  value = "${aws_iam_role.role.unique_id}"
}

output "aws_iam_role_create_date" {
  value = "${aws_iam_role.role.create_date}"
}

output "aws_iam_role_policy_id" {
  value = "${aws_iam_role_policy.policy.*.id}"
}

output "aws_iam_role_policy_name" {
  value = "${aws_iam_role_policy.policy.*.name}"
}

output "aws_iam_role_policy_policy" {
  value = "${aws_iam_role_policy.policy.*.policy}"
}

output "aws_iam_role_policy_role" {
  value = "${aws_iam_role_policy.policy.*.role}"
}
