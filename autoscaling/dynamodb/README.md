# autoscaling/dynamodb

This module allows you to apply autoscaling to a DynamoDB table.

## Usage

Here's an example that auto scales both read and write capacity:

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

If you only want auto scaling in one dimension, you can omit the parameters for the other dimension.
For example, a table which only has reads scaling:

```hcl
module "readonly_dynamo_autoscaling" {
  source = "git::https://github.com/wellcometrust/terraform.git//autoscaling/dynamodb?ref=v6.3.0"

  table_name = "my_readonly_table"

  enable_read_scaling     = true
  read_target_utilization = 70
  read_min_capacity       = 1
  read_max_capacity       = 100
}
```
