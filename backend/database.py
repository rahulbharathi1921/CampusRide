import mysql.connector
from mysql.connector import Error
from config import Config

def get_connection():
    try:
        return mysql.connector.connect(
            host=Config.DB_HOST,
            database=Config.DB_NAME,
            user=Config.DB_USER,
            password=Config.DB_PASSWORD
        )
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

def execute_query(query, params=None, fetch_all=True):
    connection = get_connection()
    if not connection:
        return None
    
    cursor = None
    try:
        cursor = connection.cursor(dictionary=True)
        cursor.execute(query, params or ())
        if fetch_all:
            return cursor.fetchall()
        return cursor.fetchone()
    except Error as e:
        print(f"Database Error: {e}")
        return None
    finally:
        if cursor: cursor.close()
        if connection: connection.close()
