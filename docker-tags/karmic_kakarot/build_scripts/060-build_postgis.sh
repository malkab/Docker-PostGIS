#!/bin/bash

# Compilation of PostGIS

cd /usr/local/src/postgis-$POSTGIS_VERSION

echo
echo ---------------------------------------
echo Configuring PostGIS
echo ---------------------------------------
echo

./configure --with-topology --with-raster

echo
echo ---------------------------------------
echo Building PostGIS
echo ---------------------------------------
echo

make

echo
echo ---------------------------------------
echo Check PostGIS
echo ---------------------------------------
echo

make check

echo
echo ---------------------------------------
echo Installing PostGIS
echo ---------------------------------------
echo

make install

ldconfig
