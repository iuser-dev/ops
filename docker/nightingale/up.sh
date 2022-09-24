#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

if [ ! -f "docker-compose.yml" ]; then
cp docker-compose.init.yml docker-compose.yml
docker-compose up -d
sed -i -e 's/- \.\/initsql/# - \.\/initsql/' docker-compose.yml
else
docker-compose up -d
fi


./nginx.sh
