sudo apt-get update
sudo apt-get install python3-pip python3-dev libpq-dev postgresql postgresql-contrib
sudo -i -u postgres
psql

#     dump
# pg_dump db_name > db_dump.sql
#     import
# psql -h 127.0.0.1 -d db_name -U user -f db_dump.sql