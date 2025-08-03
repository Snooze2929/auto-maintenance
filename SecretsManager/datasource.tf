data "terraform_remote_state" "aurora" {
  backend = "local" # または "remote"（Terraform Cloudなど）
  config = {
    path = "../Database/terraform.tfstate"  # 相対パスでAurora側のstateファイルを指定
  }
}

data "aws_cloudformation_export" "aws_vpc" {
  name = "MakeNetwork-VpcId"
}

data "aws_cloudformation_export" "private_subnet1a" {
  name = "MakeNetwork-PrivateSubnet1A"
}

data "aws_cloudformation_export" "private_subnet1c" {
  name = "MakeNetwork-PrivateSubnet1C"
}

data "aws_cloudformation_export" "EC2_SG" {
  name = "MakeNetwork-InstanceSecurityGroupEc2"
}