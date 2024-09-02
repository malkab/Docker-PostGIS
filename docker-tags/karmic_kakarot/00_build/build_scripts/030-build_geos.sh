#!/bin/bash

# Compilation of GEOS

cd /usr/local/src/geos-$GEOS_VERSION

mkdir build
cd build

cmake ..
make
ctest
make install

ldconfig
