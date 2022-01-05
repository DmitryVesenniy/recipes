# mint/ubuntu
sudo apt install -y mongodb
sudo apt install mongo-tools

# manjaro
pamac build mongodb-bin
systemctl start mongodb

# проверить 
mongo

# dump
mongodump --host="ip:port" --out=/media/jack/dev/works/makadam/backups/mongo_09.04.20
mongodump --db RoadMap --host="ip:port" --out=/media/jack/dev/works/makadam/backups/mongo_09.04.20
mongodump --db RoadMap --authenticationDatabase admin --username user --password 12345 --host="ip:port" --out=/media/jack/dev/works/makadam/backups/mongo_19.05.20
# restore
mongorestore /home/jack/backup/

#errors services
chown -R mongodb:mongodb /var/lib/mongodb
chown mongodb:mongodb /tmp/mongodb-27017.sock
