import boto3
import psycopg2
import json
import traceback
import logging
from botocore.exceptions import ClientError
from db_con import get_db_connection

def select_pg_stat_exe(secret):
    conn = get_db_connection(secret)

    try:
        conn.autocommit = True
        with conn.cursor() as cur:
            cur.execute("""
                        SELECT state, query, datname
                        FROM pg_stat_activity
                        WHERE (query LIKE 'VACUUM%' OR query LIKE 'ANALYZE%')
                        AND state = 'active';
                        """)
            
            result = cur.fetchall()

            if not result:
                return "completed"
            else:
                return "running"

            print(result)

    except Exception as e:
        logger.error("exception: %s", e)
        logger.error(traceback.format_exc())
    finally:
        conn.close()