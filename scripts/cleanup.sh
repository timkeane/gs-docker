#!/bin/bash

TODAY=`date +"%Y-%m-%d"`
LOG="/usr/local/tomcat/logs/catalina.${TODAY}.log"
READY=`grep "Server startup" $LOG`
while [ "${READY}" == "" ]; do
  sleep 1
  READY=`grep "Server startup" $LOG`
done
rm -f /data_dir/security/masterpw.info
