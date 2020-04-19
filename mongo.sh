sudo apt install -y mongodb

sudo apt install mongo-tools

# dump
mongodump --host="ip:port" --out=/media/jack/dev/works/makadam/backups/mongo_09.04.20
mongodump --db RoadMap --host="ip:port" --out=/media/jack/dev/works/makadam/backups/mongo_09.04.20
# restore
mongorestore /home/jack/backup/

#errors services
chown -R mongodb:mongodb /var/lib/mongodb
chown mongodb:mongodb /tmp/mongodb-27017.sock
