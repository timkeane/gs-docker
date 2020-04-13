# gs-docker

Build a GeoServer image with specified plugins and data directory.

### help

`./build.sh --help`

`./build.sh -h`

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
