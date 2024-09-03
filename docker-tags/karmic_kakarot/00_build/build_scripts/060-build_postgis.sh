#!/bin/bash

# Compilation of PostGIS

cd /usr/local/src/postgis-$POSTGIS_VERSION

echo
echo -----------------------------------------------------------------
echo
echo Configure
echo
echo -----------------------------------------------------------------
echo

./configure --with-topology --with-raster

echo
echo -----------------------------------------------------------------
echo
echo Build
echo
echo -----------------------------------------------------------------
echo

make

echo
echo -----------------------------------------------------------------
echo
echo Install
echo
echo -----------------------------------------------------------------
echo

make install

ldconfig
