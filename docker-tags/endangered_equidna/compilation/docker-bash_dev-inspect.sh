#!/bin/bash

# Creates a bash session into the PostGIS compilation image for
# debugging purposes

. ../env.env

docker run -ti --rm \
    -v `pwd`/:/ext-src/ \
    --entrypoint /bin/bash \
    --workdir /usr/local/src/ \
    malkab/postgis_compilation:$DOCKER_IMAGE_TAG
