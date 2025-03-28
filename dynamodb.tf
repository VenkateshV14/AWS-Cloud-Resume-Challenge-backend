resource "aws_dynamodb_table" "visitor_counter" {
  name         = "visitorCounter"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "VisitorCounterTable"
  }
}

resource "null_resource" "initialize_dynamodb_item" {
  depends_on = [aws_dynamodb_table.visitor_counter]

  provisioner "local-exec" {
    command = <<EOT
      ITEM_EXISTS=$(aws dynamodb get-item --table-name visitorCounter --key '{"id": {"S": "counter"}}' --query "Item" --output text)
      if [ "$ITEM_EXISTS" = "None" ]; then
        aws dynamodb put-item --table-name visitorCounter --item '{"id": {"S": "counter"}, "visits": {"N": "0"}}'
      else
        echo "Item already exists, skipping creation."
      fi
    EOT
  }
}
