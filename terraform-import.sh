#!/bin/bash
set -e

echo "🔧 Initializing Terraform..."
terraform init

echo "⏳ Attempting to import aws_dynamodb_table.visitor_counter..."
terraform import aws_dynamodb_table.visitor_counter visitorCounter

echo "⏳ Attempting to import aws_iam_role.lambda_exec_role..."
terraform import aws_iam_role.lambda_exec_role lambda-dynamodb-exec-role

echo "⏳ Attempting to import aws_iam_policy.lambda_dynamodb_policy..."
terraform import aws_iam_policy.lambda_dynamodb_policy arn:aws:iam::442042539767:policy/lambda-dynamodb-access-policy

echo "⏳ Attempting to import aws_lambda_function.visitor_counter..."
terraform import aws_lambda_function.visitor_counter visitorCounterFunction

echo "⏳ Attempting to import aws_apigatewayv2_api.visitor_api..."
terraform import aws_apigatewayv2_api.visitor_api 9l2tv5xuna

echo "⏳ Attempting to import aws_apigatewayv2_stage.default..."
terraform import aws_apigatewayv2_stage.default 9l2tv5xuna/\$default

echo "⏳ Attempting to import aws_apigatewayv2_integration.lambda_integration..."
terraform import aws_apigatewayv2_integration.lambda_integration 9l2tv5xuna/3428rnc

echo "⏳ Attempting to import aws_apigatewayv2_route.get_count_route..."
terraform import aws_apigatewayv2_route.get_count_route 9l2tv5xuna/ivag6bt

echo "⏳ Attempting to import aws_lambda_permission.apigw_lambda..."
terraform import aws_lambda_permission.apigw_lambda visitorCounterFunction/AllowHttpApiInvoke


echo "✅ All resources imported successfully!"
