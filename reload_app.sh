#!/bin/bash
set -ex
now=`date +%Y%m%d-%H%M%S`

# Python
if [ -e conf/isubata.python.service ]; then
  cp conf/isubata.python.service /etc/systemd/system/isubata.python.service
fi

# System
if [ -e conf/sysctl.conf ]; then
  cp conf/sysctl.conf /etc/sysctl.conf
fi
sysctl -p

systemctl daemon-reload
systemctl restart isubata.python
journalctl -f -u isubata.python
