RELEASE_TYPE: minor

This release exposes some new parameters on the _sqs_ module:

*   `visibility_timeout_seconds`
*   `message_retention_seconds`
*   `max_message_size`
*   `delay_seconds`
*   `receive_wait_time_seconds`

These are passed directly to parameters of the same name on [_aws_sqs_queue_](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#visibility_timeout_seconds).
Defaults are as before, so there should be no change to your queues until you override one of the parameters above.
