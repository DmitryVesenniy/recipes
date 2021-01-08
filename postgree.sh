sudo apt-get update
sudo apt-get install python3-pip python3-dev libpq-dev postgresql postgresql-contrib
sudo -i -u postgres
psql

# входим в систему postgres=#
sudo -u postgres psql
# Входим под конкреtным юзером
sudo -u postgres psql -h localhost -d mydatabase -U myuser -p <port>

#     dump
# pg_dump -U user -h 127.0.0.1 database > db_dump.sql
#     import
# psql -h 127.0.0.1 -d db_name -U user -f db_dump.sql

