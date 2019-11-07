data "aws_ssm_parameter" "image" {
  count = "${length(var.services)}"

  name = "/${var.project}/images/${var.label}/${var.services[count.index]}"
}

variable "services" {
  type = "list"
}

// This is a map of SSM param paths to some value
// SSM Params are used to hold ECR image URIs
// That can then be fed to ECS config
// See: https://github.com/wellcometrust/platform/tree/master/docs/rfcs/013-release_deployment_tracking

locals {
  images = "${zipmap(var.services, data.aws_ssm_parameter.image.*.value)}"
}
