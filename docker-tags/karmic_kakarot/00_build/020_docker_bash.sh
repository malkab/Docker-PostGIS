#!/bin/bash

# Use this container to test and debug compilation scripts

# Load env variables
. ../env.sh

docker run -ti --rm \
    --name postgis_build_test \
    -v $(pwd):/source \
    malkab/postgis_build:${DOCKER_IMAGE_TAG}
