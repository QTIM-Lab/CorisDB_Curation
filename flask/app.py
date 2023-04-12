from flask import Flask, jsonify
from flask_cors import CORS
import psycopg, json, json, datetime

app = Flask(__name__)
CORS(app)

DB = [{'name': 'Alice', 
      'email': 'alice@outlook.com'},
      {'name': 'Ben', 
      'email': 'ben@outlook.com'}]

# DB talking to postgres
host='0.0.0.0'
conn = psycopg.connect(dbname='coris_db', user='ophuser', password='OOOppphhhP4$$', host=host, port='5432')


@app.route('/api')
def test():
    return jsonify(DB[0])

@app.route('/api/connection_details')
def connection_details():
    return jsonify(DB[0])

@app.route('/api/postgres')
def api_postgres():
    # Open a cursor to perform database operations
    with conn.cursor() as cur:
        cur.execute("""select * from ophthalmologycurrentmedications limit 1;""")
        data = cur.fetchall()
        # Execute a command: this creates a new table

    data_row = data[0]
    date_row_prepped = [i if type(i) != datetime.datetime else i.year for i in data_row]
    # json.dumps(date_row_prepped)
    return_json = json.dumps(date_row_prepped)

    return return_json



if __name__ == "__main__":
    app.run(host='0.0.0.0')