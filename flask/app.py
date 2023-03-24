from flask import Flask, jsonify
import psycopg, json, json, datetime

app = Flask(__name__)

DB = [{'name': 'Alice', 
      'email': 'alice@outlook.com'},
      {'name': 'Ben', 
      'email': 'ben@outlook.com'}]

# DB talking to postgres
host='0.0.0.0'
conn = psycopg.connect(dbname='', user='', password='$$', host=host, port='')



@app.route('/api')
def api():
    return jsonify(DB[0])

@app.route('/api_postgres')
def api_postgres():
    # Open a cursor to perform database operations
    with conn.cursor() as cur:
        cur.execute("""select * from ophthalmologycurrentmedications limit 1;""")
        data = cur.fetchall()
        # Execute a command: this creates a new table

    data_row = data[0]
    date_row_prepped = [i if type(i) != datetime.datetime else i.year for i in data_row]
    return_json = json.dumps(date_row_prepped)

    return return_json



if __name__ == "__main__":
    app.run(host='0.0.0.0')