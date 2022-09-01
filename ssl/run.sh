#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
. /etc/profile
set -ex

./lib/ssl.js
