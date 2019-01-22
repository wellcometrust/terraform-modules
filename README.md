# Wellcome Trust Terraform modules

[![Build Status](https://travis-ci.org/wellcometrust/terraform-modules.svg?branch=master)](https://travis-ci.org/wellcometrust/terraform-modules)

Some [https://www.terraform.io/](Terraform) modules developed at the Wellcome Trust.

Currently in use on:

- https://github.com/wellcometrust/platform
- https://github.com/wellcometrust/wellcomecollection.org

## Usage

Reference your module source as shown below. Use `ref=v1.0.0` to pin your module at a particular version.

### Example

```tf
module "router_alb" {
  source  = "git::https://github.com/wellcometrust/terraform.git//terraform/ecs_alb?ref=v1.0.0"
  name    = "loris"
  subnets = ["${module.vpc_router.subnets}"]

  loadbalancer_security_groups = [
    "${module.router_cluster_asg.loadbalancer_sg_https_id}",
    "${module.router_cluster_asg.loadbalancer_sg_http_id}",
  ]

  certificate_domain = "api.wellcomecollection.org"
  vpc_id             = "${module.vpc_router.vpc_id}"

  alb_access_log_bucket = "${aws_s3_bucket.alb-logs.id}"
}
```
## Developing

PRs will need to include a `RELEASE.md` file in the root of the repo following this structure:

```md
RELEASE_TYPE: major 

This is a description of the changes in the PR!
```

Release type can be "major", "minor" or "patch" following [Semantic Versioning](http://semver.org/) guidelines.

Merged PRs are automatically tagged with the appropriate version change.

