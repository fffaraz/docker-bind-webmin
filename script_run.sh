#!/bin/bash
set -euxo pipefail

ROOT_PASSWORD=${ROOT_PASSWORD:-password}
WEBMIN_ENABLED=${WEBMIN_ENABLED:-true}

echo "root:$ROOT_PASSWORD" | chpasswd

mkdir -p /data/bind
[ ! -d /data/bind/etc ] && mv /etc/bind /data/bind/etc
rm -rf /etc/bind
ln -sf /data/bind/etc /etc/bind
chmod -R 0775 /data/bind/etc
chown -R bind:bind /data/bind
mkdir -p /data/bind/lib
chown bind:bind /data/bind/lib
rm -rf /var/lib/bind
ln -sf /data/bind/lib /var/lib/bind

mkdir -p /data/webmin
chmod -R 0755 /data/webmin
chown -R root:root /data/webmin
[ ! -d /data/webmin/etc ] && mv /etc/webmin /data/webmin/etc
rm -rf /etc/webmin
ln -sf /data/webmin/etc /etc/webmin

[ "$WEBMIN_ENABLED" == "true" ] && /etc/init.d/webmin start
exec /usr/sbin/named -g -u bind
