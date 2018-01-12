RELEASE_TYPE: patch

This fixes a bug in the ALB alarms introduced in v6.1.0 for _ecs/service_.

We added a new ALB alarm for "not enough healthy hosts".  Previously it would
fire if the number of healthy hosts was _equal_ to the minimum allowed number
(minimum healthy percentage * desired count) -- even though this is normal
behaviour, e.g. when ECS is changing task definitions.

Now the alarm only fires if the number of hosts drops _below_ the minimum
allowed number.
