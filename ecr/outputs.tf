output "repository_url" {
  value = "${aws_ecr_repository.repository.repository_url}"
}

output "name" {
  value = "${aws_ecr_repository.repository.name}"
}
