#!/bin/bash

# Exit immediately if a command fails
set -e

echo "🔧 Initializing Terraform..."
terraform init

echo "📦 Importing existing DynamoDB Table: visitorCounter"
terraform import aws_dynamodb_table.visitor_counter visitorCounter

echo "🛡️ Importing existing IAM Role: lambda-dynamodb-exec-role"
terraform import aws_iam_role.lambda_exec_role lambda-dynamodb-exec-role

# You can add more import commands here if needed in the future

echo "✅ All resources imported successfully!"
