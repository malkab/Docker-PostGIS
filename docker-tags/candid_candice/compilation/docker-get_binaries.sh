#!/bin/bash

docker run -ti --rm \
    -v `pwd`/:/ext-out/ \
    malkab/postgis_compilation:candid_candice

