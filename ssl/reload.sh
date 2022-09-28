#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

sudo service nginx reload
sudo service chasquid restart
./run.sh

