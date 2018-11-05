resource "aws_cognito_user_pool" "pool" {
  name = "${local.namespace}"

  admin_create_user_config = {
    allow_admin_create_user_only = true
  }

  password_policy = {
    minimum_length = 8
  }
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "my_auth_domain"
  user_pool_id = "${aws_cognito_user_pool.pool.id}"
}

resource "aws_cognito_user_pool_client" "example" {
  name = "${local.namespace} - Example client"

  allowed_oauth_flows = [
    "client_credentials",
  ]

  explicit_auth_flows = [
    "CUSTOM_AUTH_FLOW_ONLY",
  ]

  allowed_oauth_scopes = [
    "${aws_cognito_resource_server.api.scope_identifiers}",
  ]

  supported_identity_providers = ["COGNITO"]

  generate_secret        = true
  refresh_token_validity = 1

  user_pool_id = "${aws_cognito_user_pool.pool.id}"
}

# Creates an example service for cognito to auth

resource "aws_cognito_resource_server" "api" {
  identifier = "https://api.example.com/v1"
  name       = "Example API"

  scope = [
    {
      scope_name        = "a_scope"
      scope_description = "An example scope"
    },
  ]

  user_pool_id = "${aws_cognito_user_pool.pool.id}"
}

# Creates cognito authorizor for API Gateway

resource "aws_api_gateway_authorizer" "cognito" {
  name          = "cognito"
  type          = "COGNITO_USER_POOLS"
  rest_api_id   = "${module.gateway.id}"
  provider_arns = ["${aws_cognito_user_pool.pool.arn}"]
}