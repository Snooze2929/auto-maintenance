output "db_username" {
  value = aws_rds_cluster.auto_maintenance_pg_cluster.master_username
}

output "db_password" {
  value = random_password.db_password.result
  sensitive = true
}

output "db_endpoint" {
  value = aws_rds_cluster.auto_maintenance_pg_cluster.endpoint
}

output "db_name" {
  value = aws_rds_cluster.auto_maintenance_pg_cluster.database_name
}

