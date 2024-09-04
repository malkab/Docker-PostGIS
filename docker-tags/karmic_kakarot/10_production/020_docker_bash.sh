#!/bin/bash

# Use this container to test the production image

# Load env variables
. ../env.sh

docker run -ti --rm \
    --name postgis_production_bash \
    -e LOCALE=es_ES \
    -p 6432:5432 \
    -v $(pwd):$(pwd) \
    --workdir $(pwd) \
    --entrypoint /bin/bash \
    malkab/postgis:${DOCKER_IMAGE_TAG}
