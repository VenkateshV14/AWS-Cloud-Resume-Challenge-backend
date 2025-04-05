#!/bin/bash
set -e

echo "🔧 Initializing Terraform..."
terraform init

echo "📦 Importing existing DynamoDB Table: visitorCounter"
terraform import aws_dynamodb_table.visitor_counter visitorCounter

echo "🛡️ Importing existing IAM Role: lambda-dynamodb-exec-role"
terraform import aws_iam_role.lambda_exec_role lambda-dynamodb-exec-role

echo "🔐 Importing existing IAM Policy: lambda-dynamodb-access-policy"
terraform import aws_iam_policy.lambda_dynamodb_policy arn:aws:iam::442042539767:policy/lambda-dynamodb-access-policy

echo "🧠 Importing existing Lambda Function: visitorCounterFunction"
terraform import aws_lambda_function.visitor_counter visitorCounterFunction

echo "✅ All resources imported successfully!"
