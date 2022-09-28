#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

./cron.import.sh

cd ../..

git clone --depth=1 git@github.com:user-tax-dev/freeom_renew.git

git clone --depth=1 --recursive git@github.com:user-tax-key/key.git

cd key

./init.sh

cd smtp

./init.sh
