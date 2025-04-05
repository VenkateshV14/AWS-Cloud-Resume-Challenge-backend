import json
import boto3
import os
from decimal import Decimal

os.environ["AWS_DEFAULT_REGION"] = "us-east-1"
dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("visitorCounter")


def lambda_handler(event, context):
    try:
        # Atomically increment the visit count
        response = table.update_item(
            Key={"id": "counter"},
            UpdateExpression="ADD visits :inc",
            ExpressionAttributeValues={":inc": Decimal(1)},
            ReturnValues="UPDATED_NEW",
        )

        # Extract the updated count
        visits = int(response["Attributes"]["visits"])

        return {
            "statusCode": 200,
            "headers": {"Access-Control-Allow-Origin": "*"},
            "body": json.dumps(
                {"visits": visits, "message": "Counter updated successfully"}
            ),
        }

    except Exception as e:
        return {"statusCode": 500, "body": json.dumps({"error": str(e)})}
