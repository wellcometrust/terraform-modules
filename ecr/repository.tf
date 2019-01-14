resource "aws_ecr_repository" "repository" {
  name = "${var.namespace}/${var.id}"
}
