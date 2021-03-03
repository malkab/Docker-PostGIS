#!/bin/bash

docker run -ti --rm \
    -v `pwd`/:/ext-out/ \
    malkab/postgis_compilation:blighted_behemoth

mv binaries ../Production/packages
