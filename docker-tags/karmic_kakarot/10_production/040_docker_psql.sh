#!/bin/bash

# Load env variables
. ../env.sh

docker run -ti --rm \
    --name docker_postgis_test_psql \
    --network=container:docker_postgis_test \
    --user 1000:1000 \
    -v $(pwd):$(pwd) \
    --workdir $(pwd) \
    -e "HOST=localhost" \
    -e "PORT=5432" \
    -e "DB=postgres" \
    -e "USER=postgres" \
    -e "PASS=postgres_aaa" \
    --entrypoint /bin/bash \
    malkab/postgis:${DOCKER_IMAGE_TAG} \
    -c run_psql.sh
