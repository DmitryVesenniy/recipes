curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable test"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo adduser $(whoami) docker