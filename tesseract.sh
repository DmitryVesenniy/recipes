#!/bin/bash
sudo apt update
sudo apt-get install tesseract-ocr libtesseract-dev libleptonica-dev
sudo apt install -y mongodb
sudo apt-get install g++
sudo apt-get install python-dev
sudo apt-get install libsqlite3-dev python3-dev libffi-dev libssl-dev build-essential libssl-dev \
    libffi-dev libxml2-dev libxslt1-dev zlib1g-dev
sudo apt install python3-pip
sudo pip3 install --upgrade setuptools
sudo pip3 install -r requiments.txt
sudo pip3 install -U requests[socks] 
