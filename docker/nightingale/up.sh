#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

if [ ! -f "docker-compose.yml" ]; then
cp docker-compose.init.yml docker-compose.yml
docker-compose up -d
fi

sed -i -e "/^$1/c$2" docker-compose.yml

./nginx.sh
