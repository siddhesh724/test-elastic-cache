

output "ec-param-id" {
  value = aws_elasticache_parameter_group.tf_ec_pg.id
}

output "sg-id" {
  value = aws_security_group.allow_tls.id
}

output "cloudwatchlog-ec" {
  value = aws_cloudwatch_log_group.ec-log.arn
}

output "cloudwatchlog-ec-eng" {
  value = aws_cloudwatch_log_group.ec-eng-log.arn
}