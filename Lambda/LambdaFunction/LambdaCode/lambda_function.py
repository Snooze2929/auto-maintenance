import boto3
import psycopg2
import json
import traceback
import logging
from botocore.exceptions import ClientError

logger = logging.getLogger()
logger.setLevel(logging.INFO)

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

def select_pg_stat_exe(secret):
    conn = get_db_connection(secret)

    try:
        conn.autocommit = True
        with conn.cursor() as cursor:
            cursor.execute("""
                SELECT state, query, datname
                FROM pg_stat_activity
                WHERE query ILIKE 'VACUUM%' OR query ILIKE 'REINDEX%' OR query ILIKE 'ANALYZE%'
            """)
            result = cursor.fetchall()
            print(result)
            return result

    except Exception as e:
        logger.error("exception: %s", e)
        logger.error(traceback.format_exc())
    finally:
        conn.close()

def lambda_handler(event, context):

    secret_name = "auto-maintenance-secret"
    get_secret_result = get_secret(secret_name)

    print(get_secret_result)

    status = select_pg_stat_exe(get_secret_result)

    print(status)
