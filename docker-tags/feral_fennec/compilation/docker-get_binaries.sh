#!/bin/bash

# This script exports the binaries needed to build a production PostGIS
# Docker image from the assets compiled by the compilation Docker image

. ../env.env

docker run -ti --rm \
    -v $(pwd)/:/ext-out/ \
    malkab/postgis_compilation:$DOCKER_IMAGE_TAG
