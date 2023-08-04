# Vue dev
```bash
docker compose exec vue sh
node
```

```javascript
var url = "http://0.0.0.0:80/api"
async function getText(url) {
  let x = await fetch(url);
  let y = await x.text();
  console.log(y);
}
getText(url)

var url = "http://0.0.0.0:80/api"
console.log(url)
fetch(url).then(response => response.json()).then(data => {console.log(data)}).catch(error => {});
```

# Flask
docker compose exec flask bash
pip install psycopg
apt-get update -y; apt-get install telnet -y;

# check local ip
ping 10.141.122.34
telnet 10.141.122.34 5432
telnet localhost 5432
ssh bearceb@10.141.122.34
docker run -it --rm --add-host=database:10.141.122.34 postgres psql -h 10.141.122.34 -U ophuser


#
  --add-host=database:10.141.122.34 \
docker run \
  -it \
  --rm \
  --network=host \
  ubuntu:latest bash
  postgres bash



ss -plunt



docker run -it --rm --network=host postgres bash

psql -h 10.141.122.34 -U ophuser

psql -U ophuser coris_db -h 172.17.0.1
psql -U ophuser coris_db -h 10.141.122.34
psql -U ophuser coris_db -h soms-slce-oph1

# work
psql -U ophuser coris_db -h 0.0.0.0
psql -U ophuser coris_db -h localhost
psql -U ophuser coris_db -h 127.0.0.1

# docker flask container ip
"Gateway": "192.168.32.1",
vue "IPAddress": "192.168.32.3",
nginx "IPAddress": "192.168.32.2",
flask "IPAddress": "192.168.32.4",