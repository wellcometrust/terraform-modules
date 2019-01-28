variable "secret_env_vars" {
  description = "Secure environment variables to pass to the container"
  type        = "map"
}

variable "secret_env_vars_length" {}

variable "execution_role_name" {}
