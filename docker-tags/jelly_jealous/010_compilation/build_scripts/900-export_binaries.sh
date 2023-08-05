#!/bin/bash

# Final release of binaries

# This script exports the binaries needed to build a production PostGIS
# Docker image from the assets compiled by the compilation Docker image

echo -----------------------------------------------------------------
echo
echo Exporting binaries ...
echo
echo -----------------------------------------------------------------

# Folder creation
cd ..
rm -Rf exported_binaries
mkdir -p exported_binaries/binaries

# Export of the key folders
cp --parents -r /usr/local/bin/ $(pwd)/exported_binaries/binaries
cp --parents -r /usr/local/lib/ $(pwd)/exported_binaries/binaries
cp --parents -r /usr/local/share/ $(pwd)/exported_binaries/binaries

# Change permissions to 1000:1000
chown -R 1000:1000 exported_binaries

echo -----------------------------------------------------------------
echo
echo Exporting binaries ... Done!
echo
echo -----------------------------------------------------------------
