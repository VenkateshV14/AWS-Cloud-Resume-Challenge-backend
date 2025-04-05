variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "table_name" {
  description = "DynamoDB table's name"
  default     = "visitorCounter"
}

variable "lambda_function_name" {
  description = "Lambda function's name"
  default     = "visitorCounterFunction"
}

variable "apigateway_name" {
  description = "Api gateway's name"
  default     = "vsitorCounterAPI"
}
