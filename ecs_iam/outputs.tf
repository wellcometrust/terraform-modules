output "task_role_name" {
  value = "${aws_iam_role.task_role.name}"
}

output "instance_role_name" {
  value = "${aws_iam_role.role.name}"
}

output "instance_profile_name" {
  value = "${aws_iam_instance_profile.instance_profile.name}"
}
