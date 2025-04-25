#!/bin/bash
sudo yum update -y &&
sudo yum install nginx -y &&
sudo systemctl start nginx &&
sudo systemctl enable nginx &&
echo "<h1>Hello Genlogs!!!</h1>" >/usr/share/nginx/html/index.html &&

# install python3 and pip
sudo yum install python3-pip -y
sudo yum groupinstall "Development Tools" -y &&
sudo yum install python3-devel gcc -y &&
sudo pip3 install flask uwsgi &&

# create directory for flask app
APP_DIR="/home/ec2-user/flaskapp"
mkdir -p $APP_DIR

# create a simple flask app
cat >$APP_DIR/app.py <<EOF
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "<h1>Hey Genlogs, What's up!</h1>"
EOF

# create a wsgi file
cat >$APP_DIR/wsgi.py <<EOF
from app import app

if __name__ == "__main__":
    app.run()
EOF

# to serve the flask app
cat >$APP_DIR/uwsgi.ini <<EOF
[uwsgi]
module = wsgi:app
master = true
processes = 1
socket = 127.0.0.1:8080
chmod-socket = 660
vacuum = true
die-on-term = true
chdir = $APP_DIR
EOF

# Nginx config
sudo tee /etc/nginx/conf.d/flaskapp.conf >/dev/null <<EOF
server {
    listen 80;
    server_name _;

    location / {
        include uwsgi_params;
        uwsgi_pass 127.0.0.1:8080;
    }
}
EOF

# start nginx and uwsgi
sudo systemctl restart nginx

#start uwsgi 
#cd $APP_DIR
#sudo uwsgi --ini uwsgi.ini &

# check if uwsgi is running 
#ps aux | grep uwsgi