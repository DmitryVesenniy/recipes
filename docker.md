sudo docker images -a   #Посмотреть все образы
sudo docker ps -as      #Посмотреть все контейнеры
sudo docker rm test     #Удалить контейнер (может понадобится нмер)
sudo docker rmi test     #Удалить образы

docker stop $(docker ps -a -q) #остановить все докер контейнеры

sudo docker image prune -a -f     #удалить все образы(не запущенные)
sudo docker container prune -f    #удалить все контейнеры(не используемые)


sudo docker build --name test -f Dockerfile.test .   #Собираем контейнер test - имя контейнера, Dockerfile.test - файл, изх которого будет делаться контейнер

sudo docker run test    #Запускаем контейнер

По-умолчанию Docker кеширует каждый шаг и формируя кеш сборок. Чтобы отключить кеш, например для использования последнего apt-get update, используйте флаг --no-cache.
docker build --no-cache -t trukhinyuri/nginx

sudo docker run -p 8080:8080 -td test
Где первый 8080 является локальным портом, а второй 8080 является портом контейнера.

Допустим у вас есть 2 контейнера: web и db. Чтобы создать связь, удалите контейнер web и пересоздайте с использованием команды --link name:alias.
docker run -d -P --name web --link db:db trukhinyuri/webapp python app.py

#--add-host добавляем хост контейнеру, теперь в самом контейнере можно обращаться к хосту не по ip, а по псевдониму
sudo docker run --add-host=database:192.168.43.179 -p 8080:8000 -v $(pwd):/var/www  --name molnya molnya



Проимер докер файла:
    FROM python:3.6.6-alpine3.8           # Родительский контейнер

    ADD . /                               # Добавить родительскую папку
    RUN pip install  pyyaml requests      # Выполнить при создании контейнера

    CMD python3 -m unittest test.py       # строка которая будет работать при запуске контейнер
    
    
    
    
    
#Пример запуска hbase из dockera
sudo docker run -p 9090:9090 -ti harisekhon/hbase

sudo docker stop temp

# Пример создания динамического pods
kompose convert --file ../docker-compose.yml

#docker-compose

sudo docker-compose -f docker-compose.override.yml up --build
