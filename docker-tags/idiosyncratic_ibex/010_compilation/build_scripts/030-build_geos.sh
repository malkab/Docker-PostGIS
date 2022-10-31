#!/bin/bash

# Compilation of GEOS

echo
echo ---------------------------------------
echo Configuring GEOS
echo ---------------------------------------
echo

cd /usr/local/src/geos

tar -xvf geos-$GEOS_VERSION.tar.bz2

cd geos-$GEOS_VERSION

mkdir build
cd build

cmake ..

echo
echo ---------------------------------------
echo Building GEOS
echo ---------------------------------------
echo

make

echo
echo ---------------------------------------
echo Testing GEOS
echo ---------------------------------------
echo

ctest

echo
echo ---------------------------------------
echo Installing GEOS
echo ---------------------------------------
echo

make install

ldconfig
