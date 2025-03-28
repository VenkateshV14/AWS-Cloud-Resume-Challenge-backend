#!/bin/bash
set -e  # Exit immediately if any command fails

# Declare resources to import
declare -A resources=(
    ["aws_dynamodb_table.visitor_counter"]="visitorCounter"
    ["aws_iam_role.lambda_role"]="lambda_dynamodb_role"
    ["aws_apigatewayv2_api.visitor_api"]="zp9g72q3uc"  # Replace with actual API ID if needed
    ["aws_lambda_function.visitor_counter_lambda"]="VisitorCounterFunction"
)

# Run Terraform init before importing
terraform init -backend=true

# Loop through resources and import them
for resource in "${!resources[@]}"; do
    id="${resources[$resource]}"
    echo "Importing $resource with ID $id..."
    
    # Try importing, but continue if already imported
    terraform import $resource $id || echo "$resource already imported or not found."
done
