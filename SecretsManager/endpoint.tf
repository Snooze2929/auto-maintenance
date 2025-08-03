# SecretsManagerのエンドポイント
resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id            = data.aws_cloudformation_export.aws_vpc.value
  service_name      = "com.amazonaws.ap-northeast-1.secretsmanager"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [
    data.aws_cloudformation_export.private_subnet1a.value,
    data.aws_cloudformation_export.private_subnet1c.value
  ]

  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  tags = {
    Name = "secretsmanager-vpc-endpoint"
  }
}

# エンドポイントのセキュリティグループ
resource "aws_security_group" "endpoint_sg" {
  name        = "secretsmanager-endpoint-sg"
  description = "SG for Secrets Manager VPC Endpoint"
  vpc_id      = data.aws_cloudformation_export.aws_vpc.value
}

# セキュリティグループのインバウンドルール
resource "aws_security_group_rule" "endpoint_ingress_from_ec2" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.endpoint_sg.id
  source_security_group_id = data.aws_cloudformation_export.EC2_SG.value
  description              = "Allow HTTPS from EC2 SG"
}