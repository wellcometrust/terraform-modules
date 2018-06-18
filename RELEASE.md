RELEASE_TYPE: minor

This release deprecates the following variables:

*   `config_vars_length` in `ecs/service/ecs_task`
*   `env_vars_length` in `ecs/service`
*   `env_vars_length` in `sqs_autoscaling_service`

Their existence was always a nasty hack around some Terraform interpolation
issues, and it looks like we can get rid of them.  They can be safely removed
with no effect.
