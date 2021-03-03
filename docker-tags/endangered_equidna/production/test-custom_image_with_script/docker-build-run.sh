#!/bin/bash

# Creates the test image and runs the test
# They are a little bit delayed, be patient

. ../../env.env

docker build \
    -t=testpostgis-deleteme \
    --build-arg DOCKER_IMAGE_TAG=$DOCKER_IMAGE_TAG \
    .

docker run -ti --rm \
    -p 8888:5432 \
    --workdir / \
    --name testpostgis-deleteme \
    testpostgis-deleteme

docker rmi testpostgis-deleteme
