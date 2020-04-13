# gs-docker

Build a GeoServer image with specified plugins and data directory.

### help

`./build.sh --help`

`./build.sh -h`

```
USAGE:
  ./build.sh [OPTIONS] GEOSERVER_DATA_DIR
    OR
  ./build.sh GEOSERVER_DATA_DIR

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
```

### usage examples:

```
./build.sh --version=2.17 \
  --plugins=vectortiles,monitor \
  --community=backup-restore,s3-geotiff \
  --console-disabled=true \
  <path-to-gs-data-dir>
```

```
./build.sh -v 2.17 \
  -p vectortiles,monitor \
  -c backup-restore,s3-geotiff \
  -d=true \
  <path-to-gs-data-dir>
```
