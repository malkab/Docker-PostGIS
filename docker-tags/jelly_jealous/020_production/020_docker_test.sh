#!/bin/bash

# -----------------------------------------------------------------
#
# Starts a PG container
#
# -----------------------------------------------------------------
# Check mlkctxt to check. If void, no check will be performed. If NOTNULL,
# any activated context will do, but will fail if no context was activated.
MATCH_MLKCTXT=default

# Check mlkctxt
if command -v mlkctxt &> /dev/null ; then

    mlkctxtcheck $MATCH_MLKCTXT

    if [ ! $? -eq 0 ] ; then

        echo Invalid context set, required $MATCH_MLKCTXT

        exit 1

    fi

fi

docker run -ti --rm \
    --name docker_postgis_test \
    --hostname docker_postgis_test \
    -e LOCALE=es_ES \
    -p 5432:5432 \
    malkab/postgis:$(mlkp docker_image_tag)
