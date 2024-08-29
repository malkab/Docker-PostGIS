#!/bin/bash

# Use this container to test and debug compilation scripts

# Load env variables
. ../env.sh

docker run -ti --rm \
    --name postgis_${DOCKER_IMAGE_TAG}_test \
    --hostname postgis_${DOCKER_IMAGE_TAG}_test \
    -v $(pwd):/source \
    --workdir /source \
    malkab/postgis_build:${DOCKER_IMAGE_TAG}
