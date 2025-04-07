#!/bin/bash
set -e

# Variables (Edit if needed)
ACCOUNT_ID="442042539767"
API_ID="9l2tv5xuna"
STAGE_NAME="default"

# Helper function
import_resource() {
  local type=$1
  local name=$2
  local id=$3

  echo "⏳ Attempting to import $type.$name..."
  if terraform import "$type.$name" "$id"; then
    echo "✅ Successfully imported $type.$name"
  else
    echo "⚠️  Skipping import of $type.$name (not found or not importable)"
  fi
}

echo "🔧 Initializing Terraform..."
terraform init

# ---- DynamoDB ----
import_resource aws_dynamodb_table visitor_counter visitorCounter

# ---- IAM ----
import_resource aws_iam_role lambda_exec_role lambda-dynamodb-exec-role
import_resource aws_iam_policy lambda_dynamodb_policy arn:aws:iam::${ACCOUNT_ID}:policy/lambda-dynamodb-access-policy

# ---- Lambda ----
import_resource aws_lambda_function visitor_counter visitorCounterFunction

# ---- API Gateway ----
import_resource aws_apigatewayv2_api visitor_api $API_ID
import_resource aws_apigatewayv2_stage default ${API_ID}/${STAGE_NAME}

# ---- Integration ----
echo "🔍 Fetching Integration ID for API ID: $API_ID..."
INTEGRATION_ID=$(aws apigatewayv2 get-integrations --api-id $API_ID --query 'Items[0].IntegrationId' --output text 2>/dev/null)

if [[ "$INTEGRATION_ID" != "None" && "$INTEGRATION_ID" != "" ]]; then
  import_resource aws_apigatewayv2_integration lambda_integration ${API_ID}/${INTEGRATION_ID}
else
  echo "⚠️  No Integration found for API $API_ID"
fi

# ---- Route ----
echo "🔍 Fetching Route ID for API ID: $API_ID..."
ROUTE_ID=$(aws apigatewayv2 get-routes --api-id $API_ID --query 'Items[?RouteKey==`GET /`].RouteId' --output text 2>/dev/null)

if [[ "$ROUTE_ID" != "None" && "$ROUTE_ID" != "" ]]; then
  import_resource aws_apigatewayv2_route get_count_route ${API_ID}/${ROUTE_ID}
else
  echo "⚠️  No Route found for API $API_ID"
fi

echo "🧩 Import phase complete! Running terraform apply next..."
terraform apply -auto-approve
