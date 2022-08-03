#!/bin/bash
echo "nameserver 77.88.8.8" > /etc/resolv.conf
apt update && apt-get -y install wget postgresql-client
mkdir -p ~/.postgresql
wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.postgresql/root.crt
chmod 0600 ~/.postgresql/root.crt