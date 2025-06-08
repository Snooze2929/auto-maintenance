resource "aws_lambda_layer_version" "psycopg2_layer" {

  filename         = "./psycopg2-3.12.zip"
  layer_name       = "psycopg2-layer"
  compatible_runtimes = ["python3.12"]
  description      = "Psycopg2 Layer"
  
}
