#!/bin/bash
set -ex
now=`date +%Y%m%d-%H%M%S`

# Nginx
if [ -e /var/log/nginx/access.log ]; then
  mv /var/log/nginx/access.log /var/log/nginx/access.log.$now
fi

if [ -e conf/nginx.conf ]; then
  cp conf/nginx.conf /etc/nginx/nginx.conf
fi

# Python
if [ -e conf/isubata.python.service ]; then
  cp conf/isubata.python.service /etc/systemd/system/isubata.python.service
fi

systemctl daemon-reload
systemctl reload nginx
systemctl restart mysql isubata.python
journalctl -f -u nginx -u isubata.python
