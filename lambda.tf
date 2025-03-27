resource "aws_lambda_function" "visitor_counter_lambda" {
  filename      = "lambda_function.zip"
  function_name = "VisitorCounterFunction"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"

  source_code_hash = filebase64sha256("lambda_function.zip")

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.visitor_counter.name
    }
  }
}
