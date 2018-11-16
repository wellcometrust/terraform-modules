output "role_name" {
  value = "${aws_iam_role.iam_role.name}"
}

output "role_arn" {
  value = "${aws_iam_role.iam_role.arn}"
}
