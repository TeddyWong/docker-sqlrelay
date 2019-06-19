#!/bin/bash -e
rm -f /root/run/sqlrelay/*.pid
sleep 5
sqlr-start -localstatedir /root/
tail -f