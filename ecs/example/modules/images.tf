locals {
  project_id    = "my_project"
  release_label = "latest"
}

module "images" {
  source = "../../modules/images"

  project = "${local.project_id}"
  label   = "${local.release_label}"

  services = [
    "service_one",
    "service_two",
  ]
}

resource "aws_ssm_parameter" "service_one_image" {
  name  = "/my_project/images/latest/service_one"
  type  = "String"
  value = "strm/helloworld-http"
}

resource "aws_ssm_parameter" "service_two_image" {
  name  = "/my_project/images/latest/service_two"
  type  = "String"
  value = "strm/helloworld-http"
}

locals {
  service_one = "${module.images.services["service_one"]}"
  service_two = "${module.images.services["service_two"]}"
}

// module.images.services:
//{
//  "/my_project/images/latest/service_one": "123412341234.dkr.ecr.eu-west-1.amazonaws.com/foo:abc",
//  "/my_project/images/latest/service_two": "123412341234.dkr.ecr.eu-west-1.amazonaws.com/bar:abc"
//}

