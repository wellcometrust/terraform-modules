#Default NGINX image for ECS Services

This container image is intended to work with the services module provided in this repo.

By default this container redirects HTTPS -> HTTP.

This container needs to be started with two environment variables:

- `HTTPS_DOMAIN`: The domain to redirect HTTPS requests to
- `APP_PORT`: The application port to redirect to.
