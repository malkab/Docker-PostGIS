#!/bin/bash

# Builds the compilation image to produce binaries

# Load variables

. ../env.env

docker build \
    -t=malkab/postgis_compilation:$DOCKER_IMAGE_TAG \
    --build-arg PG_VERSION=$PG_VERSION \
    --build-arg GEOS_VERSION=$GEOS_VERSION \
    --build-arg PROJ4_VERSION=$PROJ4_VERSION \
    --build-arg GDAL_VERSION=$GDAL_VERSION \
    --build-arg POSTGIS_VERSION=$POSTGIS_VERSION \
    .
