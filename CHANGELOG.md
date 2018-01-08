# CHANGELOG

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
