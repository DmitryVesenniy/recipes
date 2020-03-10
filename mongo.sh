sudo apt install -y mongodb

sudo apt install mongo-tools

# dump
mongodump --host="ip:port" --out=/media/jack/dev/works/makadam/backups/mongo_05.03.20
# restore
mongorestore /home/jack/backup/
