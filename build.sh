#!/usr/bin/env bash

VERSION=2.17
PLUGINS="vectortiles,monitor"
COMMUNITY="backup-restore"
CONSOLE_DISABLED=true

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

for arg in "${@}"
do
  case $arg in
    -h|--help)
    usage 0
    ;;
    --version=*)
    VERSION="${arg#*=}"
    shift
    ;;
    -v)
    VERSION="${2}"
    shift
    shift
    ;;
    --plugins=*)
    PLUGINS="${arg#*=}"
    shift
    ;;
    -p)
    PLUGINS="${2}"
    shift
    shift
    ;;
    --community=*)
    COMMUNITY="${arg#*=}"
    shift
    ;;
    -c)
    COMMUNITY="${2}"
    shift
    shift
    ;;
    --console-disabled=*)
    CONSOLE_DISABLED="${arg#*=}"
    shift
    ;;
    -d)
    CONSOLE_DISABLED="${2}"
    shift
    shift
    ;;
    *)
    DATA_DIR="${1}"
    shift
    ;;
  esac
done

if [ "${DATA_DIR}" = "" ]; then
  echo -e "\e[31mERROR: GEOSERVER_DATA_DIR is a required argument\e[0m"
  usage 1
fi

echo \
  && echo DATA_DIR=${DATA_DIR} \
  && echo VERSION=${VERSION} \
  && echo PLUGINS=${PLUGINS} \
  && echo COMMUNITY=${COMMUNITY} \
  && echo CONSOLE_DISABLED=${CONSOLE_DISABLED} \
  && echo

rm -rf ./.data_dir
mkdir ./.data_dir
cp -r ${DATA_DIR}/* ./.data_dir

docker build \
  --build-arg DATA_DIR="${DATA_DIR}" \
  --build-arg VERSION="${VERSION}" \
  --build-arg PLUGINS="${PLUGINS}" \
  --build-arg COMMUNITY="${COMMUNITY}" \
  --build-arg CONSOLE_DISABLED="${CONSOLE_DISABLED}" . \

rm -rf ./.data_dir