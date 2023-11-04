#!/usr/bin/env bash
EXE=$(realpath "$0")
DIR=$(dirname $EXE)
cd $DIR
set -ex

NGINX_USER=www-data
NGINX_HOME=/mnt/www
if ! [ "$UID" -eq $(id -u $NGINX_USER) ]; then
mkdir -p $NGINX_HOME
sudo chown $NGINX_USER:$NGINX_USER $NGINX_HOME
systemctl stop nginx
usermod -d $NGINX_HOME -u $(id -u $NGINX_USER) $NGINX_USER
systemctl start nginx || true
exec sudo -u $NGINX_USER "$EXE" "$@"
fi

cd $NGINX_HOME
HOST=$1

source $DIR/dns.sh

echo $HOST

acme=$HOME/.acme.sh/acme.sh

if [ -z $MAIL ];then
MAIL=i@$HOST
fi

if [ ! -x "$acme" ]; then
# export ACME_GIT=usrtax/acme.sh
# curl https://ghproxy.com/https://raw.githubusercontent.com/usrtax/get.acme.sh/master/index.html | sh -s email=$MAIL
curl https://get.acme.sh | sh -s email=$MAIL
$acme --upgrade --auto-upgrade
fi

reload="$DIR/reload.sh"

if [ -f "$HOME/.acme.sh/$HOST/fullchain.cer" ]; then
echo "更新 $HOST"
$acme --force --renew -d $HOST -d *.$HOST --log --reloadcmd "$reload"
else
echo "创建 $HOST"
$acme \
--days 30 \
--log \
--issue \
--dns dns_$DNS \
-d $HOST -d *.$HOST \
--force \
--reloadcmd "$reload" \
-m "zsp@xvc.com"
fi

sudo service nginx restart || true
