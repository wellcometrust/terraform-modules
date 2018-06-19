# dlami_asg

This module provides an autoscaling group provisioned by default running instances based on the Amazon Deep Learning AMI.

We add some userdata which installs some useful modules and starts jupyter-notebook server.

This module requires an S3 bucket used by the [s3contents](https://github.com/danielfrg/s3contents) module in which to store notebooks.

## Usage

An example terraform implementation:

```tf
# Provision compute, this is by default a t2.large but can be overridden as below
module "p2_compute" {
  source = "git::https://github.com/wellcometrust/terraform-modules.git//ec2/asg?ref=v9.4.0"
  name   = "jupyter-p2"

  key_name    = "${var.key_name}"
  bucket_name = "${aws_s3_bucket.jupyter.id}"

  instance_type = "p2.xlarge"

  vpc_id      = "${module.vpc.vpc_id}"
  vpc_subnets = "${module.vpc.subnets}"
}

# S3 Bucket to store notebooks
resource "aws_s3_bucket" "jupyter" {
  bucket = "my_bucket"
  acl    = "private"

  lifecycle_rule {
    id      = "tmp"
    prefix  = "tmp/"
    enabled = true

    expiration {
      days = 30
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

# IAM to allow instance access to bucket
resource "aws_iam_role_policy" "p2_compute_data_science_bucket" {
  role   = "${module.p2_compute.instance_profile_role_name}"
  policy = "${data.aws_iam_policy_document.data_science_bucket.json}"
}

data "aws_iam_policy_document" "data_science_bucket" {
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "${aws_s3_bucket.jupyter.arn}",
      "${aws_s3_bucket.jupyter.arn}/*",
    ]
  }
}

```

## Accessing a running instance

This implementation expects you to access a running instance via an SSH tunnel.

For example:
```sh
# Find the public DNS name:
aws ec2 describe-instances --filters "Name=tag:name,Values=jupyter-t2" --output=json | jq ".Reservations[0].Instances[0].PublicDnsName"

# Open ssh tunnel
ssh -N -f -L localhost:8888:localhost:8888 ubuntu@ec2.host.name

# Visit localhost:8888 in your browser default password "password"

```

## Debugging

When an instance boots, it attempts to install a series of Python modules
with pip.  If this installation fails, it will prevent the Jupyter server
from starting.

The pip install log is written to `/home/jupyter/pip_install.log`.  If your
Jupyter server isn't starting, try looking here first.
