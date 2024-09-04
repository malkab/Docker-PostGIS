#!/bin/bash

# Load env variables
. ../env.sh

# -----------------------------------------------------------------
#
# Starts a PG container
#
# -----------------------------------------------------------------
docker run -ti --rm \
    --name postgis_production_test \
    -e LANG=es_ES.UTF-8 \
    -e POSTGRES_PASSWORD=postgres_aaa \
    -p 6432:5432 \
    malkab/postgis:${DOCKER_IMAGE_TAG}
