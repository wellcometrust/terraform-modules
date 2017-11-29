# sqs

This module allows you to create an SQS queue, with all the trimmings.

This includes:

*   Creating the queue itself
*   Creating a dead-letter queue (DLQ), and a redrive policy for sending failed messages from the original queue to the DLQ
*   A CloudWatch alarm that is raised when the DLQ is non-empty
*   An IAM policy document for reading from the queue
*   A subscription from an SNS topic to the new queue (all of the queues we use are subscribed to a corresponding SNS topic; we never write to a queue directly in normal operation)

## Usage

Here's an example of how to use the module:

```hcl
data "aws_caller_identity" "current" {}

module "queue" {
  source      = "git::https://github.com/wellcometrust/terraform.git//sqs?ref=v1.1.0"

  # Name of the new queue
  queue_name  = "my_first_queue"

  # Name of SNS topics to subscribe to
  topic_names = ["one_topic", "another_topic", "a_third_topic"]

  # SNS topic to send DLQ notifications to
  alarm_topic_arn = "dlq_alarm_topic"

  # How many times a message should be received, and never deleted, before
  # it gets marked as "failed" and sent to the DLQ.
  # (Optional, default 4)
  max_receive_count = 3

  # These are required for constructing some of the fiddly IAM bits
  aws_region = "eu-west-1"
  account_id = "${data.aws_caller_identity.current.account_id}"
}
```

## Outputs

The module exports the following attributes:

*   `id` - URL of the new queue
*   `arn` - ARN of the new queue
*   `name` - Name of the new queue
*   `read_policy` - JSON for an IAM policy that allows reading from the queue
