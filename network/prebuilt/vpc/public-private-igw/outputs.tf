output "private_subnets" {
  value = ["${module.private_subnets.subnets}"]
}

output "public_subnets" {
  value = ["${module.public_subnets.subnets}"]
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
