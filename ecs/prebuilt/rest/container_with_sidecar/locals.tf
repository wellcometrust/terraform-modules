locals {
  task_port = "${var.target_container == "app" ? var.app_container_port : var.sidecar_container_port}"
  task_name = "${var.target_container == "app" ? "app" : "sidecar"}"
}
