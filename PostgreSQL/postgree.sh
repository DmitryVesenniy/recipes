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

## MACOS
psql -l
# postgres  |<owner> | UTF8     | C       | C     |
sudo psql -U <owner> -d postgres


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
CREATE ROLE username WITH LOGIN NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION ENCRYPTED PASSWORD 'passwordstring';
COMMENT ON ROLE localtez IS 'description';

# создаем БД
CREATE DATABASE database OWNER username;
GRANT permissions ON DATABASE dbname TO username;

# установить пароль пользователя postgress
su - postgres
psql -p 55432
ALTER USER postgres PASSWORD 'newPassword';

# добавить колонку в таблицу
ALTER TABLE table ADD COLUMN column int4 NULL;

# поменять кодировку
UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
DROP DATABASE Template1;
CREATE DATABASE template1 WITH owner=postgres ENCODING = 'UTF-8' lc_collate = 'en_US.utf8' lc_ctype = 'en_US.utf8' template template0;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
CREATE DATABASE database OWNER username;
set client_encoding='utf8';

# меняем локаль сервера для того чтобы client по умолчанию был utf8
sudo apt-get install language-pack-ru
sudo update-locale LANG=ru\_RU.UTF-8
sudo reboot

# установить пароль для postgres
ALTER USER postgres PASSWORD 'password';

# dump
pg_dump -U user -h 127.0.0.1 database > db_dump.sql
# import
psql -h 127.0.0.1 -d db_name -U user -f db_dump.sql
# найти все версии psql
sudo find /usr -wholename '*/bin/postgres'
