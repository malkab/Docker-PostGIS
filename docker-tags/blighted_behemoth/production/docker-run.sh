#!/bin/bash

docker run -ti --rm \
    -v `pwd`/:/ext-out/ \
    -p 5432:5432 \
    malkab/postgis:blighted_behemoth
