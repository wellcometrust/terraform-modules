resource "aws_ecr_repository" "repository" {
  name = "${var.namespace}/${var.id}"

  lifecycle {
    prevent_destroy = true
  }
}
