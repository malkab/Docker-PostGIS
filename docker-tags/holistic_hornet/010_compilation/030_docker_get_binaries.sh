#!/bin/bash

# This script exports the binaries needed to build a production PostGIS
# Docker image from the assets compiled by the compilation Docker image
# Check mlkcontext to check. If void, no check will be performed
MATCH_MLKCTXT=common





# ---

# Check mlkcontext

# Check mlkctxt is present at the system
if command -v mlkctxt &> /dev/null
then

  if ! mlkctxt -c $MATCH_MLKCTXT ; then exit 1; fi

fi

docker run -ti --rm \
    -v $(pwd)/:/ext-out/ \
    malkab/postgis_compilation:$MLKC_DOCKER_IMAGE_TAG
