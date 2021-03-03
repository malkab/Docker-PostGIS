#!/bin/bash

# Creates the production image from binaries created by the 
# compilation one.
# Check mlkcontext to check. If void, no check will be performed
MATCH_MLKCONTEXT=common





# ---

# Check mlkcontext
if [ ! -z "${MATCH_MLKCONTEXT}" ] ; then

  if [ ! "$(mlkcontext)" = "$MATCH_MLKCONTEXT" ] ; then

    echo Please initialise context $MATCH_MLKCONTEXT

    exit 1

  fi

fi

# Gets the binaries of compilation and builds the production image
cd ../010_compilation/

./030_docker_get_binaries.sh

cd ../020_production

cp -R ../010_compilation/binaries ./packages/

docker build \
  -t=malkab/postgis:$MLKC_DOCKER_IMAGE_TAG \
  --build-arg PG_VERSION=$MLKC_PG_VERSION \
  --build-arg GEOS_VERSION=$MLKC_GEOS_VERSION \
  --build-arg PROJ_VERSION=$MLKC_PROJ_VERSION \
  --build-arg GDAL_VERSION=$MLKC_GDAL_VERSION \
  --build-arg POSTGIS_VERSION=$MLKC_POSTGIS_VERSION \
  .

