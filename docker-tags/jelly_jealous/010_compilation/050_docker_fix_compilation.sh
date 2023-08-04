#!/bin/bash

# -----------------------------------------------------------------
#
# Fix the compilation container in an image called
# malkab/postgis_compilation_final:XXX.
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

docker commit \
    postgis_compilation_$(mlkp docker_image_tag) \
    malkab/postgis_compilation_final:$(mlkp docker_image_tag)
