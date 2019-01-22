output "ssm_param_arn" {
  value = "${data.aws_ssm_parameter.param.arn}"
}

output "ssm_param_name" {
  value = "${data.aws_ssm_parameter.param.name}"
}

output "ssm_param_value" {
  value = "${data.aws_ssm_parameter.param.value}"
}
