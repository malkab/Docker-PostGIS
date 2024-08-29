#!/bin/bash

# Load env variables
. env.sh

docker run -ti --rm \
    --name postgis_${DOCKER_IMAGE_TAG}_test \
    --hostname postgis_${DOCKER_IMAGE_TAG}_test \
    -e LOCALE=es_ES \
    -p 5432:5432 \
    -v $(pwd):/source \
    malkab/postgis:${DOCKER_IMAGE_TAG}
