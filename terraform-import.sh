#!/bin/bash
set -e

echo "🔧 Initializing Terraform..."
terraform init

import_resource() {
  local type=$1
  local name=$2
  local id=$3

  echo "⏳ Attempting to import $type.$name..."
  if terraform import "$type.$name" "$id"; then
    echo "✅ Successfully imported $type.$name"
  else
    echo "⚠️  Skipping import of $type.$name (not found)"
  fi
}

# Update with your AWS Account ID
ACCOUNT_ID="442042539767"
REGION="us-east-1"

# Try importing each resource
import_resource aws_dynamodb_table visitor_counter visitorCounter
import_resource aws_iam_role lambda_exec_role lambda-dynamodb-exec-role
import_resource aws_iam_policy lambda_dynamodb_policy arn:aws:iam::${ACCOUNT_ID}:policy/lambda-dynamodb-access-policy
import_resource aws_lambda_function visitor_counter visitorCounterFunction
import_resource aws_apigatewayv2_api visitor_api visitor-api
import_resource aws_apigatewayv2_stage default "visitor-api/$default"
import_resource aws_apigatewayv2_integration lambda_integration visitor-api-LambdaIntegration
import_resource aws_apigatewayv2_route get_count_route visitor-api/GET/

echo "🧩 Import phase complete! Running terraform apply next..."
terraform apply -auto-approve
