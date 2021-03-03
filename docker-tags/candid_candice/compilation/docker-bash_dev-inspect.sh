#!/bin/bash

# Creates a bash session into the PostGIS compilation image for
# debugging purposes

docker run -ti --rm \
    -v `pwd`/:/ext-src/ \
    --entrypoint /bin/bash \
    --workdir /usr/local/src/ \
    malkab/postgis_compilation:candid_candice
