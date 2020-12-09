sudo apt-get update
sudo apt-get install python3-pip python3-dev libpq-dev postgresql postgresql-contrib

# входим в систему postgres=#
sudo -u postgres psql
# Входим под конкреtным юзером
psql -h localhost -d mydatabase -U myuser -p <port>


CREATE DATABASE myproject;
CREATE USER myprojectuser WITH PASSWORD 'password';
||
CREATE ROLE myprojectuser LOGIN PASSWORD 'password';
CREATE DATABASE myproject OWNER myprojectuser;

ALTER ROLE myprojectuser SET client_encoding TO 'utf8';
ALTER ROLE myprojectuser SET default_transaction_isolation TO 'read committed';
ALTER ROLE myprojectuser SET timezone TO 'UTC';

GRANT ALL PRIVILEGES ON DATABASE myproject TO myprojectuser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to myprojectuser;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO myprojectuser;

>> psql -d dataBase
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to jerry;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO jerry;

GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public to jerry;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public to jerry;
#*************************************
# Выход
postgres=# \q

# Посмотреть все базы и их кодировки
\l
#*************************************
# Сменить кодировку (если по другому не получается):
UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
DROP DATABASE Template1;
CREATE DATABASE template1 WITH owner=postgres ENCODING = 'UTF-8' lc_collate = 'en_US.utf8' lc_ctype = 'en_US.utf8' template template0;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
DROP DATABASE <наша база>;
CREATE DATABASE <наша база>; # теперь она будет в кодировке utf8


# PYTHON
pip install django psycopg2

# settings
DATABASES = {
 'default': {
 'ENGINE': 'django.db.backends.postgresql_psycopg2',
 'NAME': 'myproject',
 'USER': 'myprojectuser',
 'PASSWORD': 'password',
 'HOST': 'localhost',
 'PORT': '',
 }
}


# Перенос данных
pg_dump -U user -F c -f dump.tar.gz db_name
pg_restore -h hostname -U username -F format -d dbname dumpfile

or

./manage.py dumpdata > dump.json
./manage.py loaddata dump.json
