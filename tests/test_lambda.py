import sys
import os
import json
from unittest.mock import patch

# Go up one level from "tests/" and add to sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from lambda_function import lambda_handler  # Your actual Lambda code


@patch("lambda_function.table")
def test_lambda_handler_success(mock_table):
    # Mock DynamoDB's response
    mock_table.update_item.return_value = {"Attributes": {"visits": 10}}

    event = {}
    context = {}
    response = lambda_handler(event, context)

    assert "statusCode" in response
    assert response["statusCode"] == 200
    body = json.loads(response["body"])
    assert body["visits"] == 10
