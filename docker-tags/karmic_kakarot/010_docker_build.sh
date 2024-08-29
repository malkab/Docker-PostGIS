#!/bin/bash

# Load env variables
. env.sh

echo Building image $DOCKER_IMAGE_TAG

docker build \
    -t malkab/postgis:$DOCKER_IMAGE_TAG \
    --build-arg DOCKER_IMAGE_TAG=$DOCKER_IMAGE_TAG \
    --build-arg GDAL_VERSION=$GDAL_VERSION \
    --build-arg GEOS_VERSION=$GEOS_VERSION \
    --build-arg POSTGIS_VERSION=$POSTGIS_VERSION \
    --build-arg PG_VERSION=$PG_VERSION \
    --build-arg PROJ_VERSION=$PROJ_VERSION \
    .
