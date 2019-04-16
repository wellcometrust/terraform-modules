# AWS Config

This module allows you to create an AWS Config Recorder and Delivery Channel, with all the trimmings.

This includes:

*   Enabling the recorder itself.
*   Functionality to check the recorder status.
*   Delivery channel S3 backend for storing the change index files.

Please note that this does not include creation of Config Rules, this is purely for the initial AWS Config setup.


## Usage

Here's an example of how to use the module:

```hcl
module "config-recorder" {
  source                        = "git::https://github.com/wellcometrust/terraform.git//config?ref=v1.1.0"
  all_supported                 = "true"
  name                          = "config-recorder"
  include_global_resource_types = "true"
}

module "config-delivery-channel" {
  source             = "git::https://github.com/wellcometrust/terraform.git//config?ref=v1.1.0"
  name               = "config-recorder"
  s3_key_prefix      = "${var.bucket_key_prefix}"
  s3_bucket_name     = "${aws_s3_bucket.wt-config-recorder-bucket.bucket}"
  delivery_frequency = "Six_Hours"
}

module "config-recorder-status" {
  source     = "git::https://github.com/wellcometrust/terraform.git//config?ref=v1.1.0"
  name       = "config-recorder"
  is_enabled = "true"
}
```

## Outputs

The module exports the following attributes:

aws_config_delivery_channel
*   `s3_bucket_name` -  (Required) The name of the S3 bucket used to store the configuration history.
*   `s3_key_prefix` - (Optional) The prefix for the specified S3 bucket.
*   `delivery_frequency` - (Optional) The frequency with which AWS Config recurringly delivers configuration snapshots. e.g. One_Hour or Three_Hours.

aws_config_configuration_recorder
*   `all_supported` - (Optional) Specifies whether AWS Config records configuration changes for every supported type of regional resource (which includes any new type that will become supported in the future). Conflicts with `resource_types`. Defaults to `true`.
*   `include_global_resource_types` - (Optional) Specifies whether AWS Config includes all supported types of global resources with the resources that it records. Requires `all_supported = true`. Conflicts with `resource_types`.
*   `resource_types` - (Optional) A list that specifies the types of AWS resources for which AWS Config records configuration changes (for example, `AWS::EC2::Instance` or `AWS::CloudTrail::Trail`). See relevant part of AWS Docs for available types.

aws_config_configuration_recorder_status
*   `name` - (Required) The name of the recorder
*   `is_enabled` - (Required) Whether the configuration recorder should be enabled or disabled.