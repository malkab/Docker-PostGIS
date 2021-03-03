#!/bin/bash

# Creates a bash session into the PostGIS compilation image for
# debugging purposes

. ../env.env

docker run -ti --rm \
    -v $(pwd)/:/ext-out/ \
    --entrypoint /bin/bash \
    --name postgis-compilation-interactive \
    --hostname postgis-compilation-interactive \
    --workdir /usr/local/src/ \
    malkab/postgis_compilation:$DOCKER_IMAGE_TAG
