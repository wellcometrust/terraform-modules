RELEASE_TYPE: patch

This fixes a bug in the ALB alarms introduced in v6.1.0.

If the number of hosts in the target group was equal to the minimum healthy
deployment percentage, the "not enough healthy hosts" alarm would fire -- even
though this is normal behaviour, e.g. when ECS is changing task definitions.

Now the alarm only fires if the number of hosts drops _below_ the minimum
healthy number.
