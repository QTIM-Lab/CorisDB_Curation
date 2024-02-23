import os, pdb
from decimal import Decimal
from flask import Flask, jsonify
from flask_cors import CORS
import psycopg, json, json, datetime

from dotenv import load_dotenv
load_dotenv()

app = Flask(__name__)
# CORS(app, origins=["*"])
CORS(app, origins=["http://localhost:3000"])

# DB talking to postgres
HOST = os.getenv("HOST")
PORT_FORWARDED = os.getenv("PORT_FORWARDED")
DBNAME = os.getenv("DBNAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_PORT = os.getenv("DB_PORT")
conn = psycopg.connect(dbname=DBNAME,
                       user=DB_USER,
                       password=DB_PASSWORD,
                       host=HOST,
                       port=DB_PORT)

# with conn.cursor() as cur:
#     cur.execute("SET CLIENT_ENCODING TO 'UTF8'")

def handle_non_serializable(obj):
    if isinstance(obj, Decimal):
        return float(obj)
    elif isinstance(obj, datetime.datetime):
        return obj.isoformat()
    raise TypeError(f"Object of type {type(obj).__name__} is not JSON serializable")

# Test route
@app.route('/api')
def test():
    DB = [{'name': 'Alice', 
           'email': 'alice@outlook.com'},
          {'name': 'Ben', 
           'email': 'ben@outlook.com'}]

    return jsonify(DB[0])

@app.route('/api/search_for_patient/<mrn>', methods=['GET'])
def search_for_patient(mrn):
    print(mrn)
    # Open a cursor to perform database operations
    with conn.cursor() as cur:
        cur.execute("""
        SELECT
        column_name
        FROM information_schema.columns
        WHERE table_schema = 'dashboard'
        AND table_name = 'encounters';        
        """)
        cols = [i[0] for i in cur.fetchall()]
        cols_indexed = {cols[i]:i for i in range(len(cols))}
        # rows = cur.fetchall()
        # for row in rows: print(str(row).encode('utf-8', errors='replace').decode('utf-8'))
        # Execute a command: this creates a new table
    print(cols)
    with conn.cursor() as cur:
        cur.execute("select * from dashboard.encounters where pat_mrn = '6498721';")
        data = cur.fetchall()
        data_list = []
        progress_note_index = cols_indexed['progress_note']
        for row in data:
            row_dict = {cols[i]:row[i] if i != progress_note_index else str(row[i].encode('utf-8')) for i in range(len(cols)) }
            data_list.append(row_dict)
    return_json = json.dumps(data_list, default=handle_non_serializable)
    print(return_json)
    return return_json

@app.route('/api/glaucoma_summary_stats')
def glaucoma_summary_stats():
    # Open a cursor to perform database operations
    with conn.cursor() as cur:
        cur.execute("""
        SELECT
        column_name
        FROM information_schema.columns
        WHERE table_schema = 'glaucoma'
        AND table_name = 'glaucoma_summary_stats';
        """)
        cols = [i[0] for i in cur.fetchall()]
        # Execute a command: this creates a new table
    print(cols)
    with conn.cursor() as cur:
        cur.execute("""select * from glaucoma.glaucoma_summary_stats;""")
        data = cur.fetchall()
        data_list = []
        for row in data:
            row_dict = {cols[i]:row[i] for i in range(len(cols))}
            data_list.append(row_dict)
    return_json = json.dumps(data_list)
    print(return_json)
    return return_json


@app.route('/api/amd_summary_stats')
def amd_summary_stats():
    # Open a cursor to perform database operations
    with conn.cursor() as cur:
        cur.execute("""
        SELECT
        column_name
        FROM information_schema.columns
        WHERE table_schema = 'amd'
        AND table_name = 'amd_summary_stats';
        """)
        cols = [i[0] for i in cur.fetchall()]
        # Execute a command: this creates a new table
    with conn.cursor() as cur:
        cur.execute("""select * from amd.amd_summary_stats;""")
        data = cur.fetchall()
        data_list = []
        for row in data:
            row_dict = {cols[i]:row[i] for i in range(len(cols))}
            data_list.append(row_dict)

    return_json = json.dumps(data_list)

    return return_json


if __name__ == "__main__":
    app.run(host='0.0.0.0')