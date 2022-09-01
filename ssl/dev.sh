#!/usr/bin/env bash
set -e
DIR=$( dirname $(realpath "$0") )

cd $DIR

exec watchexec --shell=none \
  -w ./src \
  --exts coffee,rs,wasm \
  -r \
  -- ./src/ssl.coffee
