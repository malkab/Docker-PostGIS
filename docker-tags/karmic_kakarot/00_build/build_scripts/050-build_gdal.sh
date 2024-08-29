#!/bin/bash

# Compilation of GDAL

cd /usr/local/src/gdal-$GDAL_VERSION

mkdir build
cd build

echo
echo ---------------------------------------
echo Configuring GDAL
echo ---------------------------------------
echo

cmake .. \
    -DGDAL_USE_GEOTIFF_INTERNAL=OFF \
    -DGDAL_USE_PNG_INTERNAL=OFF

echo
echo ---------------------------------------
echo Building GDAL
echo ---------------------------------------
echo

cmake --build .

echo
echo ---------------------------------------
echo Installing GDAL
echo ---------------------------------------
echo

cmake --build . --target install

ldconfig
