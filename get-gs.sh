#!/usr/bin/env bash

VERSION=${1}
IFS=',' read -ra PLUGINS <<< ${2}

mkdir ./.tmp
mkdir ./.geoserver
cd ./.tmp

wget --no-check-certificate --progress=bar:force:noscroll \
  https://build.geoserver.org/geoserver/${VERSION}.x/geoserver-${VERSION}.x-latest-war.zip
unzip -q geoserver-${VERSION}.x-latest-war.zip
unzip -q geoserver.war -d ../.geoserver
rm -rf *

for PLUGIN in "${PLUGINS[@]}" 
  do 
    ZIP="geoserver-${VERSION}-SNAPSHOT-${PLUGIN}-plugin.zip"
    wget --no-check-certificate --progress=bar:force:noscroll \
      https://build.geoserver.org/geoserver/${VERSION}.x/ext-latest/${ZIP}
    unzip -q ${ZIP}
    mv *.jar ../.geoserver/WEB-INF/lib
    rm -rf *
  done

rm -rf ./.tmp