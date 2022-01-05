# Установка PgAdmin4 + Nginx + uwsgi
## Установка PgAdmin 4
Для установки **PgAdmin 4** через **pip** необходимо выполнить команды:
```
sudo apt-get install python3-pip build-essential python3-dev libssl-dev libffi-dev
sudo pip3 install https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v4.29/pip/pgadmin4-4.29-py3-none-any.whl
```
Для инициализации конфигурации в директории */usr/local/lib/python3.5/dist-packages/pgadmin4/* необходимо создать 
файл *config_local.py*:
```
LOG_FILE = '/var/log/pgadmin/pgadmin.log'
SQLITE_PATH = '/var/lib/pgadmin/pgadmin.db'
SESSION_DB_PATH = '/var/lib/pgadmin/sessions'
STORAGE_DIR = '/var/lib/pgadmin/storage'
SERVER_MODE = True
ALLOW_SAVE_PASSWORD = True
```
и выполнить команду: 
```
python3 setup.py
```
## Установка uwsgi
Для установки **uwsgi** необходимо выполнить команду:
```
sudo apt-get install uwsgi-core uwsgi-plugin-python3
```
Для проверки неоходимо запустить **uwsgi** командой 
```
sudo uwsgi --http-socket :10000 --plugin python3 --chdir /usr/local/lib/python3.5/dist-packages/pgadmin4/ --wsgi-file /usr/local/lib/python3.5/dist-packages/pgadmin4/pgAdmin4.wsgi
```
```
sudo uwsgi --socket /tmp/pgadmin.sock --plugin python3 --chdir /usr/local/lib/python3.5/dist-packages/pgadmin4/ --wsgi-file /usr/local/lib/python3.5/dist-packages/pgadmin4/pgAdmin4.wsgi
```
и открыть в браузере ссылку *http://localhost:8000*
Далее необходимо создать сервис uwsgi с использованием systemd. Для этого необходимо в директории
*/etc/uwsgi* создать файл настроект *pgadmin.ini*:
```
[uwsgi]
uid             = www-data
gid             = www-data
plugins         = python3
chdir           = /usr/local/lib/python3.5/dist-packages/pgadmin4/
wsgi-file       = /usr/local/lib/python3.5/dist-packages/pgadmin4/pgAdmin4.wsgi
master          = true
processes       = 1
socket          = /tmp/pgadmin.sock
chmod-socket    = 664
vacuum          = true
mount           = /MyPgAdmin=pgAdmin4:app
manage-script-name = true
```
Для поддержки SSL необходимо добавить:
```
https = =0,/etc/uwsgi/pgadmin.crt,/etc/uwsgi/pgadmin.key,HIGH,!ca.crt
```
Самоподписанный сертификат (файлы /etc/uwsgi/pgadmin.crt и /etc/uwsgi/pgadmin.key) можно получить командой:
```
sudo openssl req -x509 -nodes -newkey rsa:2048 -days 365 -keyout /etc/uwsgi/pgadmin.key -out /etc/uwsgi/pgadmin.crt
```
В директорию */etc/systemd/system/* добавить файл *uwsgi@.service*:
```
[Unit]
Description=uWSGI service unit
After=syslog.target

[Service]
ExecStart=/usr/bin/uwsgi --ini /etc/uwsgi/%I.ini
ExecReload=/bin/kill -HUP $MAINPID
ExecStop=/bin/kill -INT $MAINPID
Restart=always
Type=notify
StandardError=syslog
NotifyAccess=all
KillSignal=SIGQUIT

[Install]
WantedBy=multi-user.target
```
и задействовать командой:
```
sudo systemctl enable uwsgi@pgadmin
```
## Установка Nginx
Для установки **nginx** необходимо выполнить команду:
```
sudo apt-get install nginx-full
```
а в директорию */etc/nginx/sites-available/* добавить файл настройки сайта *pgadmin.conf*:
```
upstream pgadmin {
      server unix:///tmp/pgadmin.sock;
}
server {
    listen 8000;
    server_name  $server_addr;
    charset      utf-8;
    client_max_body_size 75M;
    location / {
        include uwsgi_params;
        uwsgi_pass  pgadmin;
    }
}
server {
    listen          8001 ssl;
    server_name     $server_addr;
    charset      utf-8;
    ssl_certificate      /etc/uwsgi/pgadmin.crt;
    ssl_certificate_key  /etc/uwsgi/pgadmin.key;
    location / {
        include uwsgi_params;
        uwsgi_pass  pgadmin;
    }
}
```
Если хотим чтобы PgAdmin работал на под-директории, то ставим другие настройки:
```
server {
    listen 80;
    server_name example.com;

    client_max_body_size 56m;
    access_log  /var/log/nginx-site-acc;
    error_log /var/log/nginx-site-err;
    log_not_found off;

    location = /MyPgAdmin { rewrite ^ /MyPgAdmin/; }
    location /MyPgAdmin { try_files $uri $uri/ @MyPgAdmin; }

    location @MyPgAdmin {
        include uwsgi_params;
        uwsgi_pass  unix://tmp/pgadmin.sock;
    }

    location ^~ / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_buffer_size 16k;
        proxy_buffers 32 16k;
        proxy_connect_timeout 300;
        proxy_send_timeout 300;
        proxy_read_timeout 300;
    }
}

```

Для активации сайта необходимо в директории */etc/nginx/sites-enabled* создать ссылку на 
файл */etc/nginx/sites-available/pgadmin.conf*:
```
/etc/nginx/sites-enabled# ln -s /etc/nginx/sites-available/pgadmin.conf
```
Nginx и uwsgi запускаются под *www-data:www-data*, поэтому у настроек необходимо изменить 
владельцев командами:
```
sudo chown www-data:www-data /var/lib/pgadmin/pgadmin.db
sudo chown -R www-data:www-data /var/log/pgadmin/
sudo chown -R www-data:www-data /var/lib/pgadmin/
```
Далее необходимо перезапустить nginx & uwsgi
```
sudo systemctl restart uwsgi@pgadmin
sudo systemctl restart nginx
```
PgAdmin4 должен быть доступен по ссылке *http://localhost:8000*

Настройка Postgresql на внешний ip:
    # /etc/postgresql/9.1/main/postgresql.conf
    listen_addresses = '*'
    port = 1234

    # /etc/postgresql/9.1/main/pg_hba.conf
    hostssl  all  postgreadmin  0.0.0.0/0  md5

    su postgres
    createuser -s -r -d -P postgreadmin
    # и введите пароль
    exit

    service postgresql restart
