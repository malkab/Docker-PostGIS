#!/bin/bash

# psql into the test database. postgres password should be "aaa"

docker run -ti --rm \
    --network="host" \
    --entrypoint /bin/bash \
    malkab/postgis:candid_candice \
    -c "psql -h localhost -p 8888 -U postgres postgres"
