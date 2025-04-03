# #!/bin/bash
# set -e  # Exit immediately if any command fails

# # Declare resources to import.
# # Note: We now include the DynamoDB item and use the RouteId and Stage name from your outputs.
# declare -A resources=(
#     ["aws_dynamodb_table.visitor_counter"]="visitorCounter"
#     ["aws_iam_role.lambda_role"]="lambda_dynamodb_role"
#     ["aws_iam_policy.dynamodb_policy"]="arn:aws:iam::442042539767:policy/LambdaDynamoDBPolicy"
#     ["aws_apigatewayv2_api.visitor_api"]="x99v98x8s9"
#     ["aws_apigatewayv2_route.visitor_route"]="x99v98x8s9/bntr9q6"
#     ["aws_apigatewayv2_stage.default"]="x99v98x8s9/\$default"
#     ["aws_lambda_function.visitor_counter_lambda"]="VisitorCounterFunction"
# )

# # Run Terraform init before importing
# terraform init -backend=true

# # Loop through resources and import them
# for resource in "${!resources[@]}"; do
#     id="${resources[$resource]}"
#     echo "Importing $resource with ID $id..."
    
#     # Try importing; if it’s already imported, just note that.
#     terraform import $resource "$id" || echo "$resource already imported or not found."
# done
