#!/bin/bash

# Builds the compilation image to produce binaries
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

docker build \
  -t=malkab/postgis_compilation:$MLKC_DOCKER_IMAGE_TAG \
  --build-arg PG_VERSION=$MLKC_PG_VERSION \
  --build-arg GEOS_VERSION=$MLKC_GEOS_VERSION \
  --build-arg PROJ_VERSION=$MLKC_PROJ_VERSION \
  --build-arg GDAL_VERSION=$MLKC_GDAL_VERSION \
  --build-arg POSTGIS_VERSION=$MLKC_POSTGIS_VERSION \
  .
