import sys
import os

# Go up one level from "tests/" and add to sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from lambda_function import lambda_handler  # Now it should work


def test_lambda_handler():
    event = {}
    response = lambda_handler(event, None)
    assert "statusCode" in response
    assert response["statusCode"] == 200
