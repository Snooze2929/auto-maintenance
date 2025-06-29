# lambdaの実行ロール定義
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  # Lambdaから実行されることを許可する信頼ポリシー（AssumeRoleポリシー）
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# 上記で作成したlambda実行用ロールにAWS管理のポリシーを紐づける
resource "aws_iam_role_policy_attachment" "lambda_policy_attachments" {
  for_each = toset(local.lambda_maneged_policies)
  role     = aws_iam_role.lambda_exec_role.name
  policy_arn = each.key
}

resource "aws_lambda_function" "StateSelect_Lambda" {
  filename      = "./LambdaCode/lambda_function.zip"
  function_name = "StateSelectLambda"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  timeout       = 30
  
  source_code_hash = data.archive_file.lambda.output_base64sha256

  vpc_config {
    subnet_ids         = [
      data.aws_cloudformation_export.public_subnet1.value,
      data.aws_cloudformation_export.public_subnet2.value
    ]
    security_group_ids = [data.aws_cloudformation_export.security_group_ec2.value]
  }

    layers = [
        data.terraform_remote_state.psycopg2_layer.outputs.psycopg2_layer_arn
    ]
  }