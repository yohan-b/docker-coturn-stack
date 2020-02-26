#!/bin/bash
test -z ${KEY} && { echo "KEY variable is not defined."; exit 1; }
test -f ~/secrets.tar.gz.enc || curl -o ~/secrets.tar.gz.enc "https://cloud.scimetis.net/s/${KEY}/download?path=%2F&files=secrets.tar.gz.enc"
openssl enc -aes-256-cbc -d -in ~/secrets.tar.gz.enc | tar -zxv --strip 2 secrets/docker-coturn-stack/secret
sudo chown root. secret
sudo chmod a-r secret
sudo mv -f secret .env

unset VERSION_COTURN
export VERSION_COTURN=$(git ls-remote https://git.scimetis.net/yohan/docker-coturn.git| head -1 | cut -f 1|cut -c -10)

mkdir -p ~/build
git clone https://git.scimetis.net/yohan/docker-coturn.git ~/build/docker-coturn
sudo docker build -t coturn:$VERSION_COTURN ~/build/docker-coturn

sudo -E bash -c 'docker-compose up -d'

rm -rf ~/build
