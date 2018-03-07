# CHANGELOG

## v8.0.0 - 2018-03-07

This update allows you to specify multiple hosted zones within one hosted zone role.

## v7.0.1 - 2018-02-22

This release adds `min_capacity` and `max_capacity` to the `sqs_autoscaling_service` to allow to customise the minimum and maximum number of tasks per service.

## v6.4.1 - 2018-02-05

This release adds a `asg_security_group_ids` output on the ecs/cluster module. It is a list containing the list of security groups that instances in the cluster belong to

## v6.4.0 - 2018-01-22

This release exposes some new parameters on the _sqs_ module:

*   `visibility_timeout_seconds`
*   `message_retention_seconds`
*   `max_message_size`
*   `delay_seconds`
*   `receive_wait_time_seconds`

These are passed directly to parameters of the same name on [_aws_sqs_queue_](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#visibility_timeout_seconds).
Defaults are as before, so there should be no change to your queues until you override one of the parameters above.

## v6.3.0 - 2018-01-18

This adds a new module: _autoscaling/dynamodb_, which allows you to define auto scaling rules for DynamoDB tables.
See the [module README](autoscaling/dynamodb/README.md) for usage details.

## v6.2.0 - 2018-01-17

This adds a new parameter `enable_alb_alarm` to the *sqs_autoscaling_alarm* module.
It is passed through directly to the underlying *ecs/service* module.

It defaults to `true`; set it to `false` to disable ALB alarms in autoscaled services.

## v6.1.1 - 2018-01-15

This fixes a bug in the ALB alarms introduced in v6.1.0 for _ecs/service_.

We added a new ALB alarm for "not enough healthy hosts".  Previously it would
fire if the number of healthy hosts was _equal_ to the minimum allowed number
(minimum healthy percentage * desired count) -- even though this is normal
behaviour, e.g. when ECS is changing task definitions.

Now the alarm only fires if the number of hosts drops _below_ the minimum
allowed number.

## v6.1.0 - 2018-01-08

This adds two new CloudWatch alarms to the _ecs/service_ module:

*   One which alarms whenever the UnHealthyHostCount metric in the ALB target
    group is non-zero.

*   One which alarms whenever the HealthyHostCount metric in the ALB target
    group is less than the desired number of hosts.

These alarms are created if you pass `enable_alb_alarm = true` when creating
the instance of the module.

## v6.0.0 - 2018-01-08

Instances of the `ecs/service` module no longer ignore changes to the
`desired_count` parameter.  Practically speaking, that means you can edit the
parameter in Terraform and those changes will stick, rather than having to
adjust the desired count in a separate process.

## v5.3.0 - 2018-01-04

The `alb_priority` variable is now optional on _ecs/service_ and
_sqs_autoscaling_service_.  If you don't set an explicit ALB priority, a
priority will be randomly chosen and assigned.

This is useful if, for example, your services distinguish ALB routing targets
with non-overlapping path patterns.  One service replies to `/ingestor/`,
another to `/id_minter/`, another to `/transformer/` --- and so ALB priorities
are irrelevant for routing.

## v5.2.2 - 2017-12-21

This is a bugfix release.

There was a bug in the previous version of the _autoscaling/app/ecs_ module
that meant that autoscaling targets were continually deleted and recreated, and
getting a complete set of working targets was a bit of a "whack-a-mole"
process.

Autoscaling targets are now created consistently, and only once.

See [wellcometrust/terraform-modules #34](https://github.com/wellcometrust/terraform-modules/pull/34).

## v5.2.1 - 2017-12-19

This is a bugfix release.

Previously the _ecs/cluster_ module could throw an error if you tried
to create a cluster with a name containing an underscore (`_`).

The module creates an ALB target group with the same name, and underscores
aren't allowed in target group names.  Now it replaces underscores with hyphens
in the ALB target group name.

## v5.2.0 - 2017-12-18

This creates a new _ecs/cluster_ module for spinning up an ECS cluster with spot and on-demand instances, and auto-scaling rules for both.

The following modules have been renamed:

*   _ecs_asg_ is now _ecs/asg_
*   _ecs_alb_ is now _ecs/alb_
*   _service_ is now _ecs/service_

## v5.0.2 - 2017-12-15

This is a bugfix release.

This adds `create_before_destroy` to the autoscaling target in _autoscaling/app/ecs_.
This should fix some issues when creating `aws_appautoscaling_policy`.

## v5.0.1 - 2017-12-15

This fixes a bug in v5.0.0 where the _sqs_autoscaling_service_ module was pointing to a non-existent version of the _service_ module.
