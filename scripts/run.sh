#!/bin/bash

if [ "${RM_MASTERPW_INFO}" = "true" ]; then
  ./cleanup.sh &>/dev/null &
  disown
fi

/usr/local/tomcat/bin/catalina.sh run
