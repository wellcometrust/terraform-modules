# EFS

AWS Elastic File System module.

This module creates:
- An EFS filesystem
- Mount points for each subnet specified
- Permissions to access the filesystem for the specified security groups


## Usage

```tf
module "my_efs_module" {
  source = "efs"
  name   = "my_efs_module"

  vpc_id  = "${var.vpc_id}"
  subnets = ["${var.my_subnets}"]

  # Security group IDs for ingress
  efs_access_security_group_ids = [${var.security_group_ids}"]
}
```

## Outputs

The module exports the following attributes:

*   `efs_id` - ID if the EFS filesystem

