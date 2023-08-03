#!/bin/bash

# Compilation of Proj

cd /usr/local/src/proj-$PROJ_VERSION

mkdir build
cd build

echo
echo ---------------------------------------
echo Configuring PROJ
echo ---------------------------------------
echo

cmake ..

echo
echo ---------------------------------------
echo Building PROJ
echo ---------------------------------------
echo

cmake --build .

echo
echo ---------------------------------------
echo Installing PROJ
echo ---------------------------------------
echo

cmake --build . --target install

echo
echo ---------------------------------------
echo Installing proj-data
echo ---------------------------------------
echo

projsync --system-directory --all

echo
echo ---------------------------------------
echo Testing proj-data
echo ---------------------------------------
echo

ctest

ldconfig
