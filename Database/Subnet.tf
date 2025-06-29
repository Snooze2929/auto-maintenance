resource "aws_db_subnet_group" "auto-maintenance-subnet-group" {
  name       = "auto-maintenance-subnet-group"
  subnet_ids = [
    data.aws_cloudformation_export.private_subnet1.value,
    data.aws_cloudformation_export.private_subnet2.value,
  ]
}