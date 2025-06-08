# -------------------------------------
# Aurora Cluster
# -------------------------------------
resource "aws_rds_cluster" "auto_maintenance_pg_cluster" {
  cluster_identifier              = "aurora-pg-cluster"
  engine                          = "aurora-postgresql"
  engine_version                  = "15.10"
  master_username                 = local.db_creds.username
  master_password                 = local.db_creds.password
  database_name                   = "auto_maintenance_db"
  vpc_security_group_ids          = [data.aws_cloudformation_export.rds_security_group.value]
  db_subnet_group_name            = aws_db_subnet_group.auto-maintenance-subnet-group.name
  storage_encrypted               = true
  kms_key_id                      = local.kms_alias_arn
  skip_final_snapshot             = true
  apply_immediately               = true
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_pg_param_group.name
}

# -------------------------------------
# Aurora instance（最小構成）
# -------------------------------------
resource "aws_rds_cluster_instance" "auto_maintenance_pg_instance" {
  identifier         = "auto-maintenance-pg-instance-1"
  cluster_identifier = aws_rds_cluster.auto_maintenance_pg_cluster.id
  instance_class     = "db.t4g.medium"
  engine             = aws_rds_cluster.auto_maintenance_pg_cluster.engine
  engine_version     = aws_rds_cluster.auto_maintenance_pg_cluster.engine_version
  publicly_accessible = false
  db_subnet_group_name = aws_db_subnet_group.auto-maintenance-subnet-group.name
  apply_immediately    = true
}