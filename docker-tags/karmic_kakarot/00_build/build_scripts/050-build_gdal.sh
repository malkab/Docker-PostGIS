#!/bin/bash

# Compilation of GDAL

cd /usr/local/src/gdal-$GDAL_VERSION

mkdir build
cd build

cmake .. \
    -DGDAL_USE_GEOTIFF_INTERNAL=OFF \
    -DGDAL_USE_PNG_INTERNAL=OFF

cmake --build .
cmake --build . --target install

ldconfig
