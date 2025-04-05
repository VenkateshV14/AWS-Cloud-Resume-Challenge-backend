resource "aws_lambda_function" "visitor_counter" {
  function_name    = var.lambda_function_name
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.11"
  role             = aws_iam_role.lambda_exec_role.arn

  timeout = 10
}

