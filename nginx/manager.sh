#!/bin/sh
set -e

update() {
    name=$1
    url=$2
    if echo $url | grep -q '^ssl:'; then
        url=${url#ssl:}
        cat > /etc/nginx/sites/$name <<EOF
server {
    listen 80;
    listen 443 ssl;
    server_name $name;
    ssl_certificate     /etc/nginx/ssl/$name.crt;
    ssl_certificate_key /etc/nginx/ssl/$name.key;
    location / {
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_pass $url;
    }
}
EOF
    else
        cat > /etc/nginx/sites/$name <<EOF
server {
    listen 80;
    server_name $name;
    location / {
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_pass $url;
    }
}
EOF
    fi
    nginx -s reload
}

remove() {
    name=$1
    rm -f /etc/nginx/sites/$name
    nginx -s reload
}

case $ETCD_WATCH_ACTION in
    set|update) update ${ETCD_WATCH_KEY#/neetoree/export/http/} $ETCD_WATCH_VALUE ;;
    delete) remove $ETCD_WATCH_KEY ;;
esac

