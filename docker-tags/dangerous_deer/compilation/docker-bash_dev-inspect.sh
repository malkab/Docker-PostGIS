#!/bin/bash

# Creates a bash session into the PostGIS compilation image for
# debugging purposes

docker run -ti --rm \
    -v `pwd`/:/ext-src/ \
    --entrypoint /bin/bash \
    malkab/postgis_compilation:dangerous_deer
