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

resource "aws_dynamodb_table_item" "visitor_counter_item" {
  table_name = aws_dynamodb_table.visitor_counter.name
  hash_key   = "id"

  item = <<ITEM
{
  "id": {"S": "counter"},
  "visits": {"N": "0"}
}
ITEM

  lifecycle {
    ignore_changes = [item] # Prevent overwriting the item
  }
}


