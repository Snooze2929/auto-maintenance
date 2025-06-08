output "db_username" {
  value = local.db_creds.username
}

output "db_password" {
  value = local.db_creds.password
  sensitive = true
}

output "db_endpoint" {
  value = aws_rds_cluster.auto_maintenance_pg_cluster.endpoint
}

output "db_name" {
  value = aws_rds_cluster.auto_maintenance_pg_cluster.database_name
}

