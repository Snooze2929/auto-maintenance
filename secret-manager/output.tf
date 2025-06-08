output "aurora_pg_secret_arn" {
  description = "ARN of the Aurora PostgreSQL secret"
  value       = aws_secretsmanager_secret.aurora_pg_secret.arn
}

output "aurora_pg_secret_string" {
  description = "Secret string containing the connection string"
  value       = aws_secretsmanager_secret_version.aurora_pg_secret_value.secret_string
  sensitive   = true
}