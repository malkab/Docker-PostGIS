#!/bin/bash

# -----------------------------------------------------------------
#
# Builds the production image. To do so, binaries must have been
# extracted from the compilation image at ../010/exported_binaries
#
# -----------------------------------------------------------------
# Copy the binaries from 010 here
rm -Rf ./packages/binaries
cp -R ../010_compilation/exported_binaries/binaries ./packages/binaries

docker build \
    -t malkab/postgis:jelly_jealous \
    .
