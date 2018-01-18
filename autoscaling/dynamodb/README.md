# autoscaling/dynamodb

This module allows you to apply autoscaling to a DynamoDB table.

## Usage

```hcl
module "dynamo_autoscaling" {
  source = "git::https://github.com/wellcometrust/terraform.git//autoscaling/dynamodb?ref=v6.3.0"

  table_name = "my_table"

  enable_read_scaling     = true
  read_target_utilization = 70
  read_min_capacity       = 1
  read_max_capacity       = 100

  enable_write_scaling     = true
  write_target_utilization = 80
  write_min_capacity       = 1
  write_max_capacity       = 200
}
```
