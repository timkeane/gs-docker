#!/bin/bash

VERSION=2.17
PLUGINS="vectortiles,monitor"
COMMUNITY="backup-restore"
CONSOLE_DISABLED=true
RM_MASTERPW_INFO=false
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
                            (default ${VERSION})
                            Examples:
                                -v 2.17
                                --version=2.17

  -p, --plugins             Specify a comma delimited list of GeoServer Plugins.
                            (default ${PLUGINS})
                            Examples:
                                -p vectortiles,monitor
                                --plugins=vectortiles,monitor

  -c, --community           Specify a comma delimited list of GeoServer Community Plugins.
                            (default ${COMMUNITY})
                            Examples:
                                -c backup-restore,s3-geotiff
                                --community=backup-restore,s3-geotiff

  -d, --console-disabled    Specify whether or not to include the GeoServer admin console.
                            (default ${CONSOLE_DISABLED})
                            Examples:
                                -d false
                                --console-disabled=true

  -r, --rm-masterpw-info    Specify whether or not to automatically remove the masterpw.info file.
                            (default ${RM_MASTERPW_INFO})
                            Examples:
                                -r false
                                --rm-masterpw-info=true

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
    -r | --rm-masterpw-info ) RM_MASTERPW_INFO="${2}"; shift 2 ;;
    -r=* | --rm-masterpw-info=* ) RM_MASTERPW_INFO="${1#*=}"; shift ;;
    -h | --help ) usage 0; shift ;;
    --) shift; break ;;
    -* | --*=) echo -e "\e[31mERROR: Unsupported flag ${1}\e[0m"; usage 1 ;;
    *) DATA_DIR+=("${1}"); shift ;;
  esac
done

echo \
  && echo VERSION=${VERSION} \
  && echo PLUGINS=${PLUGINS} \
  && echo COMMUNITY=${COMMUNITY} \
  && echo DATA_DIR=${DATA_DIR} \
  && echo CONSOLE_DISABLED=${CONSOLE_DISABLED} \
  && echo RM_MASTERPW_INFO=${RM_MASTERPW_INFO} \
  && echo

if [ "${DATA_DIR}" = "" ]; then
  echo -e "\e[31mERROR: Path to GEOSERVER_DATA_DIR is a required argument\e[0m"
  usage 1
fi

rm -rf ./.data_dir
mkdir ./.data_dir
cp -r ${DATA_DIR}/* ./.data_dir

docker build \
  --build-arg VERSION="${VERSION}" \
  --build-arg PLUGINS="${PLUGINS}" \
  --build-arg COMMUNITY="${COMMUNITY}" \
  --build-arg CONSOLE_DISABLED="${CONSOLE_DISABLED}" \
  --build-arg RM_MASTERPW_INFO="${RM_MASTERPW_INFO}" \
  --tag "geoserver:${VERSION}" .

rm -rf ./.data_dir
