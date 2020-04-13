#!/usr/bin/env bash

VERSION=2.17
PLUGINS="vectortiles,monitor"
COMMUNITY="backup-restore"
CONSOLE_DISABLED=true
DATA_DIR=()

usage() {
  this_file=${0}
  read -r -d "" USAGE <<EOF
USAGE:
  ${this_file} [OPTIONS] GEOSERVER_DATA_DIR
    OR
  ${this_file} GEOSERVER_DATA_DIR

OPTIONS:

  -v, --version             Specify a GeoServer major version.
                            (default 2.17)
                            Examples:
                                -v 2.17
                                --version=2.17

  -p, --plugins             Specify a comma delimited list of GeoServer Plugins.
                            (default vectortiles,monitor)
                            Examples:
                                -p vectortiles,monitor
                                --plugins=vectortiles,monitor

  -c, --community           Specify a comma delimited list of GeoServer Community Plugins.
                            (default backup-restore)
                            Examples:
                                -c backup-restore,s3-geotiff
                                --community=backup-restore,s3-geotiff

  -d, --console-disabled   Specify a comma delimited list of GeoServer Community Plugins.
                            (default true)
                            Examples:
                                -d false
                                --console-disabled=false

  -h, --help                Show this message.
EOF
  echo
  echo "${USAGE}" 1>&2;
  echo
  exit $1;
}

for arg in "${@}"; do
  case "${1}" in
    -v | --version ) VERSION="${2}"; shift 2 ;;
    -v=* | --version=* ) VERSION="${1#*=}"; shift ;;
    -p | --plugins ) PLUGINS="${2}"; shift 2 ;;
    -p=* | --plugins=* ) PLUGINS="${1#*=}"; shift ;;
    -c | --community ) COMMUNITY="${2}"; shift 2 ;;
    -c=* | --community=* ) COMMUNITY="${1#*=}"; shift ;;
    -d | --console-disabled ) CONSOLE_DISABLED="${2}"; shift 2 ;;
    -d=* | --console-disabled=* ) CONSOLE_DISABLED="${1#*=}"; shift ;;
    -h | --help ) usage 0; shift ;;
    --) shift; break ;;
    -* | --*=) echo -e "\e[31mERROR: Unsupported flag ${1}\e[0m"; usage 1 ;;
    *) DATA_DIR+=("${1}"); shift ;;
  esac
done

echo \
  && echo DATA_DIR=${DATA_DIR} \
  && echo VERSION=${VERSION} \
  && echo PLUGINS=${PLUGINS} \
  && echo COMMUNITY=${COMMUNITY} \
  && echo CONSOLE_DISABLED=${CONSOLE_DISABLED} \
  && echo
