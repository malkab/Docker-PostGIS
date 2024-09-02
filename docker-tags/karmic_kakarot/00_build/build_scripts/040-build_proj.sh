#!/bin/bash

# Compilation of Proj

cd /usr/local/src/proj-$PROJ_VERSION

mkdir build
cd build

cmake ..
cmake --build .
cmake --build . --target install
projsync --system-directory --all

ldconfig
