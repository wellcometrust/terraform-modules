RELEASE_TYPE: patch

More bugfixes in the lambda module:
* Don't use data block for iam_role because it can result in race conditions
* Use different name for cloudwatch policy document and dlq policy document
* Prepend lambda to the iam role name
