resource "aws_security_group" "security_group" {
  name        = "${var.name}_endpoint"
  description = "Allows connection to our default VPC endpoints"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.name}"
  }
}
