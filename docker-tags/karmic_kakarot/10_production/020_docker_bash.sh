#!/bin/bash

# Use this container to test and debug compilation scripts

# Load env variables
. ../env.sh

docker run -ti --rm \
    --name postgis_${DOCKER_IMAGE_TAG}_test \
    --hostname postgis_${DOCKER_IMAGE_TAG}_test \
    -e LOCALE=es_ES \
    -p 6432:5432 \
    --workdir / \
    --entrypoint /bin/bash \
    malkab/postgis:${DOCKER_IMAGE_TAG}
