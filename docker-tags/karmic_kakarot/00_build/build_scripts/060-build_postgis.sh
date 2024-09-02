#!/bin/bash

# Compilation of PostGIS

cd /usr/local/src/postgis-$POSTGIS_VERSION

./configure --with-topology --with-raster

make
make install

ldconfig
