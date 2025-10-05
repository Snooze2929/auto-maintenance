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