RELEASE_TYPE: minor

Fix a silly bug in the `container_with_sidecar` module that meant environment variables didn't work.

Add IAM permissions to the `tasks/secrets` module, so your execution role has the permissions it needs to read secrets.
