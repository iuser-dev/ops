#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

if [ -x "$(command -v nginx)" ]; then
sudo service nginx reload
fi
if [ -x "$(command -v chasquid)" ]; then
sudo service chasquid restart
fi
./run.sh

