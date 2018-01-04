RELEASE_TYPE: minor

The `alb_priority` variable is now optional on _ecs/service_ and
_sqs_autoscaling_service_.  If you don't set an explicit ALB priority, a
priority will be randomly chosen and assigned.

This is useful if, for example, your services distinguish ALB routing targets
with non-overlapping path patterns.  One service replies to `/ingestor/`,
another to `/id_minter/`, another to `/transformer/` --- and so ALB priorities
are irrelevant for routing.
