import boto3
import psycopg2
import json
import traceback
import logging
from botocore.exceptions import ClientError

def get_secret(secret_name, region_name="ap-northeast-1"):
    client = boto3.client("secretsmanager", region_name=region_name)
    try:
        response = client.get_secret_value(SecretId=secret_name)
    except ClientError as e:
        raise e
    else:
        if "SecretString" in response:
            return json.loads(response["SecretString"])
        else:
            return json.loads(response["SecretBinary"])

def get_db_connection(secret):
    # デバッグ用ログ出力
    print(f"Connecting to DB: host={secret['host']}, dbname={secret['dbname']}")

    return psycopg2.connect(
        dbname=secret["dbname"],
        user=secret["username"],
        password=secret["password"],
        host=secret["host"],
        port=secret["port"]
    )