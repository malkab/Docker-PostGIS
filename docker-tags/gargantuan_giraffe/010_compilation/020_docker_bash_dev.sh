#!/bin/bash

# Creates a bash session into the PostGIS compilation image for
# debugging purposes
MATCH_MLKCONTEXT=common





# ---

# Check mlkcontext

if [ ! -z "${MATCH_MLKCONTEXT}" ] ; then

  if [ ! "$(mlkcontext)" = "$MATCH_MLKCONTEXT" ] ; then

    echo Please initialise context $MATCH_MLKCONTEXT

    exit 1

  fi

fi

docker run -ti --rm \
  -v $(pwd)/:/ext-out/ \
  --entrypoint /bin/bash \
  --name postgis-compilation-interactive \
  --hostname postgis-compilation-interactive \
  --workdir /usr/local/src/ \
  malkab/postgis_compilation:$MLKC_DOCKER_IMAGE_TAG
