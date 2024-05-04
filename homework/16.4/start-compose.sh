#!/bin/bash

source /home/ubu/secret.sh
docker login --username oauth --password $oauth_token cr.yandex


apt install -y unzip
wget https://github.com/RedRatInTheHat/shvirtd-example-python/archive/refs/heads/main.zip -O /tmp/shvirtd-example-python.zip
unzip -o /tmp/shvirtd-example-python.zip -d /opt
cd /opt/shvirtd-example-python-main
docker compose up -d