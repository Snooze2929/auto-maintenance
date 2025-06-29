/*
data "aws_cloudformation_export" "任意のterraform上での名前" {
  name = "cloudformationのコンソールの出力タブの「エクスポート名」を入力"
}
*/

data "aws_cloudformation_export" "vpc_id" {
  name = "MakeNetwork-VpcId"
}

data "aws_cloudformation_export" "rds_security_group" {
  name = "MakeNetwork-SecurityGroupRDS"
}

data "aws_cloudformation_export" "private_subnet1" {
  name = "MakeNetwork-PrivateSubnet1A"
}
data "aws_cloudformation_export" "private_subnet2" {
  name = "MakeNetwork-PrivateSubnet1C"
}

locals {
  db_creds = {
    username = "yourusername"
    password = "yourpassword"
  }

  kms_alias_arn = "arn:aws:kms:ap-northeast-1:190805427049:alias/aws/rds"
}




