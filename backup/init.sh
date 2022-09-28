#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

./cron.import.sh

cd ../..

if [ ! -d "freeom_renew" ]; then
git clone --depth=1 git@github.com:user-tax-dev/freeom_renew.git
fi

if [ ! -d "key" ]; then
git clone --depth=1 --recursive git@github.com:user-tax-key/key.git
fi

cd key

./init.sh

cd smtp

./init.sh
