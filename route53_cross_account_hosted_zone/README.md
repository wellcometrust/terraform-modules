# TCAR53HZRP!
## Terraform Cross Account Route53 Hosted Zone Role Policy

Terraform module for sharing Route53 hosted zones between accounts.

You might want to use this if you have multiple AWS accounts with one account looking after all hosted zones, but you have developers working in another account who want to update a particular hosted zone.

## Usage

Create a Terraform module like this in your existing infrastructure description.

```tf
module "my_route53_iam_role" {
  source         = "github.com/wellcometrust/tf_cross_account_route53_hosted_zones"
  account_id     = "4w54cc0un71d"
  hosted_zone_id = "H0573DZ0N31D"
  role_name      = "my_role_name"
}
```

Consumers of the role can use a link like the following to switch roles in their console:

`
https://signin.aws.amazon.com/switchrole?account=my_account_name&roleName=my_role_name
`
