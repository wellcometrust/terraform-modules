module "dynamodb_endpoint" {
  source = "./gateway_endpoint"

  service        = "dynamodb"
  vpc_id         = "${aws_vpc.vpc.id}"
  route_table_id = "${module.private_subnets.route_table_id}"
}

module "s3_endpoint" {
  source = "./gateway_endpoint"

  service        = "s3"
  vpc_id         = "${aws_vpc.vpc.id}"
  route_table_id = "${module.private_subnets.route_table_id}"
}
