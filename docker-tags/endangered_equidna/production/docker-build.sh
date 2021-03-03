#!/bin/bash

# Gets the binaries of compilation and builds the production image

. ../env.env

cd ../compilation/
./docker-get_binaries.sh
cd ../production

cp -R ../compilation/binaries ./packages/

docker build \
    -t=malkab/postgis:$DOCKER_IMAGE_TAG \
    --build-arg PG_VERSION=$PG_VERSION \
    --build-arg GEOS_VERSION=$GEOS_VERSION \
    --build-arg PROJ4_VERSION=$PROJ4_VERSION \
    --build-arg GDAL_VERSION=$GDAL_VERSION \
    --build-arg POSTGIS_VERSION=$POSTGIS_VERSION \
    .
    
rm -Rf ./packages/binaries
