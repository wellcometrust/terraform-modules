RELEASE_TYPE: major

Instances of the `ecs/service` module no longer ignore changes to the
`desired_count` parameter.  Practically speaking, that means you can edit the
parameter in Terraform and those changes will stick, rather than having to
adjust the desired count in a separate process.
