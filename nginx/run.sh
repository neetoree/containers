#!/bin/sh
set -e
/usr/bin/etcdctl exec-watch --recursive /neetoree/export/http -- /manager.sh &
/usr/sbin/nginx "$@" &
wait
