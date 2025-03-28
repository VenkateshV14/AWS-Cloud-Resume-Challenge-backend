import json
import boto3
from decimal import Decimal

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("visitorCounter")


def lambda_handler(event, context):
    response = table.get_item(Key={"id": "counter"})

    if "Item" in response:
        visits = int(response["Item"]["visits"]) + 1
    else:
        visits = 1

    table.put_item(Item={"id": "counter", "visits": Decimal(visits)})

    return {
        "statusCode": 200,
        "headers": {"Access-Control-Allow-Origin": "*"},
        "body": json.dumps(
            {"visits": visits, "message": "Counter updated successfully 🚀"}
        ),
    }
