resource "aws_lambda_function" "StateSelect_Lambda" {
  filename      = "./SelectLambdaCode/lambda_function.zip"
  function_name = "StateSelectLambda"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.12"
  timeout       = 30
  
  source_code_hash = data.archive_file.select_lambda.output_base64sha256

  vpc_config {
    subnet_ids         = [
      data.aws_cloudformation_export.private_subnet1.value,
      data.aws_cloudformation_export.private_subnet2.value
    ]
    security_group_ids = [data.aws_cloudformation_export.security_group_ec2.value]
  }

    layers = [
        data.terraform_remote_state.psycopg2_layer.outputs.psycopg2_layer_arn
    ]
  }