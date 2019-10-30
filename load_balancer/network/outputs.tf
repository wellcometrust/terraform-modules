output "arn" {
  value = "${aws_lb.network_load_balancer.arn}"
}

output "dns_name" {
  value = "${aws_lb.network_load_balancer.dns_name}"
}
