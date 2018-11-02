# AWS Lambda

This module provides:

- A lambda function
- A DLQ by default
- Cloudwatch logging
- Triggers for events from:
  - Dynamo
  - SNS
  - Cloudwatch

## Usage

This module expects you to provide a properly packaged lambda in S3 at the given location.

See `/example` folder for details.