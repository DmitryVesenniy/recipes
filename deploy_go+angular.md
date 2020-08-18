# SvpdGis-RoadTool

Инструмент для работы с дорогами и участками. Привязка видео к дорогам. Angular+Go.

deploy:
  # compile angular
  cd ui
  ng build --prod

  cd dist
  переносим папку /static в /backend

  # compile go
  go build -o backend main.go

  # делаем сервис из скомпиллированного приложения
  nano /lib/systemd/system/roadtool.service
  Вписываем:
    [Unit]
    Description=roadTool

    [Service]
    Restart=always
    RestartSec=10
    EnvironmentFile=-/home/<имя_пользователя>/env
    WorkingDirectory=/home/<имя_пользователя>/backend
    ExecStart=/home/<имя_пользователя>/backend/backend
    LimitNOFILE=524576
    LimitNPROC=524576
    User=<имя_пользователя>
    Group=<имя_пользователя>
    StandardOutput=syslog
    StandardError=syslog
    SyslogIdentifier=roadtool

  # Запускаем демона из системы
  sudo systemctl start roadtool.service
  # Останавливаем бекенд
  sudo systemctl stop roadtool.service


  #nginx:
    server {
      listen 80;
      server_name site.ru;
      client_max_body_size 56m;
      access_log /var/log/nginx-site-acc;
      error_log /var/log/nginx-site-err;
      log_not_found off;

      location ^~ / {
        proxy_pass http://localhost:<порт_приложения>;
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_buffer_size 16k;
        proxy_buffers 32 16k;
        proxy_connect_timeout 300;
        proxy_send_timeout 300;
        proxy_read_timeout 300;
      }


