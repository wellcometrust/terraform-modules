RELEASE_TYPE: patch

Modify SQS autoscaling to scale down on messages deleted <= 0 instead of messages visible on the queue.