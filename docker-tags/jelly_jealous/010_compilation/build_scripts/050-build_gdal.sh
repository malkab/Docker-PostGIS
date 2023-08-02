#!/bin/bash

# Compilation of GDAL

cd /usr/local/src/gdal

tar -xvf gdal-$GDAL_VERSION.tar.gz

cd gdal-$GDAL_VERSION
mkdir build
cd build

echo
echo ---------------------------------------
echo Configuring GDAL
echo ---------------------------------------
echo

cmake ..

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
