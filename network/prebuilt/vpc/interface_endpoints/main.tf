# The full list of services that support Interface Endpoints in the docs:
# https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html
#
# VPC endpoints aren't free ($0.01/hour per endpoint per AZ), which is
# why I haven't just created endpoints for the entire list -- but if we do
# start to push significant traffic through the NAT Gateway, we should just
# add them.

module "cloudwatch_endpoint" {
  source  = "./endpoint"
  service = "monitoring"

  security_group_ids = ["${var.security_group_id}"]
  subnet_ids         = "${var.subnet_ids}"
  vpc_id             = "${var.vpc_id}"
}

module "events_endpoint" {
  source  = "./endpoint"
  service = "events"

  security_group_ids = ["${var.security_group_id}"]
  subnet_ids         = "${var.subnet_ids}"
  vpc_id             = "${var.vpc_id}"
}

module "logs_endpoint" {
  source  = "./endpoint"
  service = "logs"

  security_group_ids = ["${var.security_group_id}"]
  subnet_ids         = "${var.subnet_ids}"
  vpc_id             = "${var.vpc_id}"
}

module "sns_endpoint" {
  source  = "./endpoint"
  service = "sns"

  security_group_ids = ["${var.security_group_id}"]
  subnet_ids         = "${var.subnet_ids}"
  vpc_id             = "${var.vpc_id}"
}

module "sqs_endpoint" {
  source  = "./endpoint"
  service = "sqs"

  security_group_ids = ["${var.security_group_id}"]
  subnet_ids         = "${var.subnet_ids}"
  vpc_id             = "${var.vpc_id}"
}
