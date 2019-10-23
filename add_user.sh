sudo useradd username
sudo mkdir /home/username
sudo passwd username
sudo chown username /home/username
sudo chgrp username /home/username
sudo usermod -s /bin/bash username

#Как выдать root-права пользователю
sudo adduser username sudo
#или
sudo useradd -ou 0 -g 0 username -m

#Как удалить пользователя
sudo userdel username
sudo rm -r /home/username/