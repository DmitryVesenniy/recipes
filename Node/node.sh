curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt-get install nodejs

# очистить кешь. Иногда помогает решать ошибки зависимостей
npm cache clear --force