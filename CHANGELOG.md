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