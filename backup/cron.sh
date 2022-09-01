#!/usr/bin/env bash

DIR=$(cd "$(dirname "$0")"; pwd)
set -ex
cd $DIR

crontab -l > cron.txt

git diff --quiet && git diff --staged --quiet && exit 0
git checkout .
git fetch --all
git reset --hard origin/main

crontab -l > cron.txt

git add -A
git commit -am 'backup crontab'
git pull
git push


