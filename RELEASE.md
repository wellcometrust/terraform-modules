RELEASE_TYPE: minor

This release adds the `log_retention_in_days` parameter to the following modules:

*   _ecs/service/ecs_task_
*   _ecs/service_
*   _ecs_script_task_
*   _lambda_
*   _sqs_autoscaling_service_
*   _userdata_

which controls the log retention policies for CloudWatch log groups.

It defaults to none (i.e. retain logs forever).
