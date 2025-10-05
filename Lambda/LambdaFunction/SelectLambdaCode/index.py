import boto3
import psycopg2
import json
import traceback
import logging
from botocore.exceptions import ClientError
from cmd import select_pg_stat_exe
from db_con import get_db_connection, get_secret

def lambda_handler(event, context):

    secret_name = "auto-maintenance-secret"
    get_secret_result = get_secret(secret_name)
    
    status = select_pg_stat_exe(get_secret_result)

    if status == "completed":
        return {
            "status": "completed"
        }
    elif status == "running":
        return {
            "status": "running"
        }
