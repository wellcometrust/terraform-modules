# s3_template_file

This module renders a template file and uploads it to an S3 bucket.

We use this to store config files in S3, because our config files often rely on AWS resource IDs.
Using Terraform to manage these ensures our config is always up to date.

## Usage

The template file should be the same format as the [built-in template_file provider][provider].

For example, suppose I had the following template:

```console
$ cat templates/iplist.template
#!/bin/bash
echo "CONSUL_ADDRESS = ${consul_address}" > /tmp/iplist
```

We could render this template, and upload the result to S3, as follows:

```hcl
module "consul_iplist" {
  source = "git::https://github.com/wellcometrust/terraform.git//services?ref=v1.2.0"

  s3_bucket = "bukkit"
  s3_key    = "tmp/iplist"

  template_path = "templates/iplist.template"
  template_vars = {
    consul_address = "1.2.3.4"
  }
}
```

[provider]: https://www.terraform.io/docs/providers/template/d/file.html
