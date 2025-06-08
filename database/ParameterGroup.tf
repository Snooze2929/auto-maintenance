# -------------------------------------
# Aurora Cluster Parameter Group
# -------------------------------------

resource "aws_rds_cluster_parameter_group" "aurora_pg_param_group" {
  name   = "aurora-pg-cluster-param"
  family = "aurora-postgresql15"

  parameter {
    name  = "log_statement"
    value = "ddl"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "0"
  }
}