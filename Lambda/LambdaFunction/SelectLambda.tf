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

resource "aws_lambda_function" "StateSelect_Lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "./LambdaCode/Code.zip"
  function_name = "StateSelectLambda"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.12"

    layers = [
        data.terraform_remote_state.layer.outputs.lambda_layer_arn
    ]
  }