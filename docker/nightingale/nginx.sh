#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

cd /etc/nginx/site
file=n9.usr.tax.conf
if [ ! -s "$file" ]; then
ln -s $DIR/$file .
fi

systemctl daemon-reload
systemctl reload nginx

