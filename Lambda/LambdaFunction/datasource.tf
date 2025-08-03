data "terraform_remote_state" "psycopg2_layer" {
  backend = "local"

  config = {
    path = "../LambdaLayer/terraform.tfstate"
    }
  }


data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "./LambdaCode"
  output_path = "lambda_function.zip"
}

data "aws_cloudformation_export" "private_subnet1" {
  name = "MakeNetwork-PrivateSubnet1A"
}

data "aws_cloudformation_export" "private_subnet2" {
  name = "MakeNetwork-PrivateSubnet1C"
}

data "aws_cloudformation_export" "security_group_ec2" {
  name = "MakeNetwork-InstanceSecurityGroupEc2"
}

locals {
  lambda_maneged_policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  ]
}