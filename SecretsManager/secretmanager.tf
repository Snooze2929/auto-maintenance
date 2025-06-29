resource "aws_secretsmanager_secret" "aurora_pg_secret" {
  name        = "aurora-pg-secret"
  description = "Aurora PostgreSQL connection string"
  kms_key_id  = "alias/aws/secretsmanager"
}

resource "aws_secretsmanager_secret_version" "aurora_pg_secret_value" {
  secret_id = aws_secretsmanager_secret.aurora_pg_secret.id

  secret_string = jsonencode({
    username = data.terraform_remote_state.aurora.outputs.db_username
    password = data.terraform_remote_state.aurora.outputs.db_password
    host     = data.terraform_remote_state.aurora.outputs.db_endpoint
    port     = 5432
    dbname   = data.terraform_remote_state.aurora.outputs.db_name
  })
}

