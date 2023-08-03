#!/bin/bash

# -----------------------------------------------------------------
#
# Runs a session inside the compilation image for compiling.
#
# -----------------------------------------------------------------
# Check mlkctxt to check. If void, no check will be performed. If NOTNULL,
# any activated context will do, but will fail if no context was activated.
MATCH_MLKCTXT=default

# Check mlkctxt
if command -v mlkctxt &> /dev/null ; then

    if [ ! -z "$MATCH_MLKCTXT" ] ; then

        mlkctxtcheck $MATCH_MLKCTXT

        if [ ! $? -eq 0 ] ; then

        echo Invalid context set, required $MATCH_MLKCTXT

        exit 1

        fi

    fi

fi

docker run -ti \
    --name postgis_compilation_$(mlkp docker_image_tag) \
    --hostname postgis_compilation_$(mlkp docker_image_tag) \
    -v $(pwd):$(pwd) \
    --workdir $(pwd) \
    malkab/postgis_compilation:$(mlkp docker_image_tag)
