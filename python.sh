sudo apt-get install build-essential checkinstall
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev python3-dev\
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev gcc make zlib1g-dev build-essential

#sudo apt-get install libmysqlclient-dev # Если работать с MySQL
#sudo apt-get install libpq-dev # пакеты для PostGre

cd /usr/src
sudo wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
sudo tar xzf Python-3.8.0.tgz

cd Python-3.8.0
sudo ./configure --enable-optimizations
sudo make altinstall
