#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR/..
set -ex

clone(){
out=$(basename $1)
if [ ! -d "$out" ]; then
git clone --recursive --depth=1 git@github.com:$1.git
else
cd $out
git fetch --all
git reset --hard origin/main
cd $DIR
fi
}

clone user-tax-key/key
clone user-tax-dev/freeom_renew

key/env/init.sh
crontab $DIR/backup/cron.txt
