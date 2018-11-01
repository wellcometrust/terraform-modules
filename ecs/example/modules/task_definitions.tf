module "task" {
  source = "../../modules/task/prebuilt/single_container"

  aws_region = "${local.aws_region}"
  task_name  = "${local.namespace}"

  container_image = "strm/helloworld-http"
  container_port  = "80"
}

module "task_with_sidecar" {
  source = "../../modules/task/prebuilt/container_with_sidecar"

  aws_region = "${local.aws_region}"
  task_name  = "${local.namespace}_with_sidecar"

  memory = "2048"
  cpu    = "1024"

  app_container_image = "strm/helloworld-http"
  app_container_port  = "80"

  app_cpu    = "512"
  app_memory = "1024"

  sidecar_container_image = "memcached"
  sidecar_container_port  = "11211"

  sidecar_cpu    = "512"
  sidecar_memory = "1024"
}
