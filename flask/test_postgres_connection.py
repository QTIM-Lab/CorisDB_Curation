docker compose exec flask bash

# python stuff
python3

# bash stuff
apt-get install telnet -y
telnet 0.0.0.0 5432


##

import psycopg, json, datetime
# import psycopg2

host='10.141.122.34'
host='192.168.32.1'
host='172.17.0.1'
host='127.0.0.1'
host='0.0.0.0'
host='localhost'

conn = psycopg.connect(dbname='', user='', password='', host=host, port='')
# conn = psycopg2.connect("dbname='' user='ophuser' host='{}' password=''".format(host))

# Open a cursor to perform database operations
with conn.cursor() as cur:
    cur.execute("""select * from ophthalmologycurrentmedications limit 1;""")
    data = cur.fetchall()
    # Execute a command: this creates a new table

data_row = data[0]
date_row_prepped = [i if type(i) != datetime.datetime else i.year for i in data_row]
return_json = json.dumps(date_row_prepped)