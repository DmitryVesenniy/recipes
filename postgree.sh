## Linux(mint, ubuntu)
sudo apt-get update
sudo apt-get install python3-pip python3-dev libpq-dev postgresql postgresql-contrib
sudo -i -u postgres
psql
# входим в систему postgres=#
sudo -u postgres psql

## ArchLinux(Manjaro)
sudo pacman -S postgresql
sudo su - postgres -c "initdb --locale ru_RU.UTF-8 -E UTF8 -D '/var/lib/postgres/data'"
sudo chown -R postgres:postgres /var/lib/postgres/
systemctl start postgresql
systemctl enable postgresql
# входим в систему postgres=#
sudo su - postgres

sudo -u postgres psql -h localhost -d mydatabase -U myuser -p <port>

# создаем супер роль
CREATE ROLE username LOGIN SUPERUSER PASSWORD 'passwordstring';

# создаем супер юзера
CREATE USER username SUPERUSER WITH PASSWORD 'passwordstring';

# Удалить роль
DROP ROLE IF EXISTS username;

# дать права роли на базу
GRANT ALL PRIVILEGES ON DATABASE myproject TO myprojectuser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to myprojectuser;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO myprojectuser;

# Входим под конкреtным юзером
sudo -u postgres psql -h localhost -d mydatabase -U myuser -p <port>

# создаем роль для базы
CREATE ROLE username WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'passwordstring';

COMMENT ON ROLE localtez IS 'description';

# dump
pg_dump -U user -h 127.0.0.1 database > db_dump.sql
# import
psql -h 127.0.0.1 -d db_name -U user -f db_dump.sql

