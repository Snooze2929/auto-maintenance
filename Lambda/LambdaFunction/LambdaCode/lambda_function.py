import psycopg2
import json
import logging
import traceback
from boto3 import client
from os import environ
from botocore import Config
from botocore.exceptions import ClientError

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def get_secret(secret_name, region_name= "ap-northeast-1"):

    client = boto3.client("secretmanager", region_name= region_name)

    try:
        response = client.get_secret_value(SecretId = secret_name)
    
    except ClientError as e:
        raise e
    
    else:
        if "SecretString" in response:
            return json.loads(response["SecretString"])
        else:
            return response["SecretBinary"]

def get_db_connection(get_secret_result):
    # シークレットから接続文字列を取得
    connection_string = get_secret_result["con"]["CONNECTION STRING"]

    # デバック用ログ出力
    print(f"Complete Connection String: {connection_string}")

    # コネクションオブジェクト(DB接続のセッション)を返す
    return psycopg2.connect(connection_string)
    
def select_pg_stat_exe(get_secret_result):
    conn = get_db_connection(get_secret_result)

    try:
        conn.autocommit = True
        with conn.cursor() as cursor:
            cursor.execute("""
                            SELECT state, query, datname
                            FROM pg_stat_activity
                            WHERE (query LIKE 'VACUUM%' OR query LIKE 'REINDEX%' OR query LIKE 'ANALYZE%')
                            """)
            result = cursor.fetchall()

            # デバックログ出力
            print(result)

            return result
    
    except Exception as e:
        logger.error("exception: %s", e)
        logger.error(traceback.format_exc())
    finally:
        conn.close()

    

def lambda_handler(event, context)

    secret_name = "auto-maintenance-secret"
    get_secret_result = get_secret(secret_name)

    status = select_pg_stat_exe

    print(status)