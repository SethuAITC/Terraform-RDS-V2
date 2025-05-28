output "db_instance_endpoint" {
  value = aws_db_instance.myrds.endpoint
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.rds_secret.arn
}
