#!/bin/bash

# Final release of binaries

# This script exports the binaries needed to build a production PostGIS
# Docker image from the assets compiled by the compilation Docker image


# Folder creation
mkdir -p /ext-out/binaries


# Export of the key folders

cp --parents -r /usr/local/bin/ /ext-out/binaries
cp --parents -r /usr/local/lib/ /ext-out/binaries
cp --parents -r /usr/local/share/ /ext-out/binaries
