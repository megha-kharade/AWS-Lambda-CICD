
locals {
  lambda_zip_location="outputs/lambda_function_hello.zip"
}

# Archive a single file.

data "archive_file" "lambda_function_hello" {
  type        = "zip"
  source_file = "lambda_function_hello.js"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "${local.lambda_zip_location}"
  function_name = "welcome"
  role          = "${"aws_iam_role.lambda_role.arn"}"
  handler       = "lambda_function_hello.handler"

  source_code_hash = filebase64sha256("welcome.zip")

  runtime = "nodejs12.x"    
}