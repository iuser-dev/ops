#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

cd /etc/nginx/site
ln -s $DIR/n9.usr.tax.conf .
systemctl daemon-reload
systemctl reload nginx

