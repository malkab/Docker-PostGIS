#!/bin/bash

# -----------------------------------------------------------------
#
# Runs all build scripts.
#
# -----------------------------------------------------------------
./010-install_dependencies.sh
./020-build_postgresql.sh
./030-build_geos.sh
./040-build_proj.sh
./050-build_gdal.sh
./060-build_postgis.sh
./900-exported_binaries.sh
