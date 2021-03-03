#!/bin/bash

. ../env.env

docker run -ti --rm \
    -v `pwd`/:/ext-out/ \
    malkab/postgis_compilation:$DOCKER_IMAGE_TAG

