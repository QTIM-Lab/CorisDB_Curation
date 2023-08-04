import os, pdb
from flask import Flask, jsonify
from flask_cors import CORS
import psycopg, json, json, datetime

from dotenv import load_dotenv
load_dotenv()

app = Flask(__name__)
CORS(app)

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


# Test route
@app.route('/api')
def test():
    DB = [{'name': 'Alice', 
           'email': 'alice@outlook.com'},
          {'name': 'Ben', 
           'email': 'ben@outlook.com'}]

    return jsonify(DB[0])


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