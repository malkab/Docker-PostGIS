#!/bin/bash

# psql into the test database. postgres password should be "aaa"

. ../../env.env

docker run -ti --rm \
    --network="host" \
    --entrypoint /bin/bash \
    -v `pwd`:/ext-src \
    --workdir /ext-src \
    malkab/postgis:$DOCKER_IMAGE_TAG \
    -c "psql -h localhost -p 8888 -U postgres postgres"
