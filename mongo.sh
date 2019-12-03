sudo apt install -y mongodb

sudo apt install mongo-tools

# dump
mongodump --host="ip:port" --out=/home/jack/backup/
# restore
mongorestore /home/jack/backup/
