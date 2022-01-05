sudo apt-get install redis-server
sudo systemctl enable redis-server.service
#sudo vim /etc/redis/redis.conf
#maxmemory 256mb
#maxmemory-policy allkeys-lru
#Приведенная выше конфигурация указывает Redis удалить любой ключ, используя алгоритм LRU, когда достигается максимальный объем памяти 256 МБ.
#sudo systemctl restart redis-server.service