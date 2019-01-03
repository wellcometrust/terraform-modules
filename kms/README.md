# KMS Module

## Key

Creates a KMS key and permissions for use.

### Usage

```tf

module "kms_key" {
  source     = "key"
  account_id = "${local.account_id}"
}

```