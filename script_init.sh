#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive
rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes

apt-get -yq update < /dev/null
apt-get -yq upgrade < /dev/null
apt-get -yq install apt-utils gnupg2 < /dev/null
apt-get -yq install apt-transport-https ca-certificates net-tools unzip wget < /dev/null
apt-get -yq install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python < /dev/null
apt-get -yq install bind9 bind9utils bind9-host < /dev/null

echo "deb https://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
wget -qO- http://www.webmin.com/jcameron-key.asc | apt-key add -

apt-get -yq update < /dev/null
apt-get -yq install webmin < /dev/null

mkdir -m 0775 -p /var/run/named
chown root:bind /var/run/named

mkdir -m 0775 -p /var/cache/bind
chown root:bind /var/cache/bind

rm -rf /var/lib/apt/lists/*

cat > /etc/bind/named.conf.options <<'EOL'
options {
	directory "/var/cache/bind";
	dnssec-validation auto;
	auth-nxdomain no; # conform to RFC1035
	listen-on-v6 { any; };
	recursion no;
	allow-transfer { none; };
};
EOL
