#!/bin/bash

# Compilation of Proj

cd /usr/local/src/proj-$PROJ_VERSION

echo
echo -----------------------------------------------------------------
echo
echo Configure
echo
echo -----------------------------------------------------------------
echo

rm -Rf build
mkdir build
cd build

cmake \
    -DCMAKE_BUILD_TYPE=Release \
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
projsync --system-directory --all

ldconfig
