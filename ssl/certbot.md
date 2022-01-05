sudo snap install core; sudo snap refresh core

sudo apt-get install certbot

# подготовительные работы
# создаем правило с таким описанием cat /etc/nginx/acme 
location /.well-known {
    root /var/www/html;
}
# после чего инклюдим в конфиг нашего сервера
server {

    ...
    include acme;
    ...

}
# это нужно для того чтобы дать доступ к файлам, которые будет создавать certbot


# Запускаем certbot, вводим почту, домен и т.д.
# Input the webroot - вводим путь до где будут создаваться временные файлы для проверки прав
# в нашем случае /var/www/html
certbot certonly -d <domain> -d  <sub.domain>

# Будет создан сертификат
/etc/letsencrypt/live/<domain>/cert.pem

# прописываем настройки в nginx

server {
    server_name example.com;
    listen example.com:443 ssl;
    access_log off;

    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;#
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;#
    ssl_trusted_certificate /etc/letsencrypt/live/example.com-0001/chain.pem;#

    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 127.0.0.1 8.8.8.8;

    add_header Strict-Transport-Security "max-age=31536000";

    expires max;
    return 301 https://www.example.com$request_uri;
}

location /.well-known {
        root /var/www/html;
    }


