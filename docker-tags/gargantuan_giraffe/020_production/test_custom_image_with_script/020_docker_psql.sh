#!/bin/bash

# psql into the test database. postgres password should be "aaa"

docker run -ti --rm \
    --network="host" \
    -v $(pwd)/assets/:/ext-src/ \
    --entrypoint /bin/bash \
    malkab/postgis:gargantuan_giraffe \
    -c "psql -h localhost -p 8888 -U postgres postgres"
