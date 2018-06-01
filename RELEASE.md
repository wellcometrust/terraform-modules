RELEASE_TYPE: patch

This change adds an `APP_NAME` environment variable to the task definition of tasks created with the `ecs` module. The `APP_NAME` variable is set to the value of the container uri used as the primary container in the service.