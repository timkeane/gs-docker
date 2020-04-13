# gs-docker

Build a GeoServer image with specified plugins and data directory.

### help

`./build.sh --help`

### usage examples:

`./build.sh --version=2.17 --plugins=vectortiles,monitor --community=backup-restore,s3-geotiff --console-disabled=true /data-dir-path`

`./build.sh -v 2.17 -p vectortiles,monitor -c backup-restore,s3-geotiff -d=true /data-dir-path`
