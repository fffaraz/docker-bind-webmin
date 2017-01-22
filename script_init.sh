#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive
apt-get -yq update < /dev/null
apt-get -yq install apt-transport-https bind9 bind9-host ca-certificates net-tools unzip wget < /dev/null
apt-get -yq install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python < /dev/null

echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
wget -qO- http://www.webmin.com/jcameron-key.asc | apt-key add -

apt-get -yq update < /dev/null
apt-get -yq install webmin < /dev/null

mkdir -m 0775 -p /var/run/named
chown root:bind /var/run/named

mkdir -m 0775 -p /var/cache/bind
chown root:bind /var/cache/bind

rm -rf /var/lib/apt/lists/*
