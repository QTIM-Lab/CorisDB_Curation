docker build -t coris_db-flask:latest ./flask

docker run -it --rm coris_db-flask:latest bash
docker rmi coris_db-flask:latest
docker save --output coris_db-flask:latest.tar coris_db-flask:latest

docker rmi coris_db-nginx:latest

# RUNs

# Install tools and python dependencies
apt update -y;
apt-get install vim -y;
# apt-get install python3.11 python3-pip -y;
apt-get install python3-pip -y;
pip install -r requirements.txt
