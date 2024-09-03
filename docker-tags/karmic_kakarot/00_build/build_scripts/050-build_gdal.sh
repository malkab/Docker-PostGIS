#!/bin/bash

# Compilation of GDAL

cd /usr/local/src/gdal-$GDAL_VERSION

echo
echo -----------------------------------------------------------------
echo
echo Configure
echo
echo -----------------------------------------------------------------
echo

mkdir build
cd build

cmake \
    -DGDAL_USE_GEOTIFF_INTERNAL=OFF \
    -DGDAL_USE_PNG_INTERNAL=OFF \
    -CMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    ..

echo
echo -----------------------------------------------------------------
echo
echo Build
echo
echo -----------------------------------------------------------------
echo

cmake --build .

echo
echo -----------------------------------------------------------------
echo
echo Install
echo
echo -----------------------------------------------------------------
echo

cmake --build . --target install

ldconfig
