module "cluster_alb" {
  source  = "alb"
  name    = "${var.name}"
  subnets = ["${var.vpc_subnets}"]

  loadbalancer_security_groups = [
    "${module.cluster_asg_spot.loadbalancer_sg_https_id}",
    "${module.cluster_asg_spot.loadbalancer_sg_http_id}",
    "${module.cluster_asg_on_demand.loadbalancer_sg_https_id}",
    "${module.cluster_asg_on_demand.loadbalancer_sg_http_id}",
  ]

  certificate_domain = "services.wellcomecollection.org"
  vpc_id             = "${var.vpc_id}"

  alb_access_log_bucket = "${var.alb_log_bucket_id}"
}