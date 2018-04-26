RELEASE_TYPE: minor

This release adds a V2 ASG module intended to supersede the existing ECS only ASG description in the `ecs` module.

## Usage:

```hcl
module "test" {
  source = "../terraform-modules/ec2/asg"
  name   = "tf-asg-v2"

  image_id = "ami-0bc19972"
  key_name = "${var.key_name}"

  subnet_list = "${module.vpc.subnets}"
  vpc_id      = "${module.vpc.vpc_id}"
}
```
