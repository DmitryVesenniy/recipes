wget https://dl.google.com/go/go<version>.linux-amd64.tar.gz
sudo tar -C /usr/lib/go<version> -xzf go<version>.linux-amd64.tar.gz

# добавим в путь поиска бинарник или создадим ссылку на бинарник в /usr/bin
export PATH=$PATH:/usr/lib/go<version>/go-1.15/bin || ln -s /usr/lib/go<version>/go-1.15/bin/go /usr/bin/go
# Дальше нужно сообщить Go, где находится наша папка для проектов, для этого с помощью GOPATH:
export GOPATH=$HOME/work/
