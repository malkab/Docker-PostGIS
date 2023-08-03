#!/bin/bash

# -----------------------------------------------------------------
#
# Removes the compilation container postgis_compilation_XXX.
# WARNING! Potential loss of information that is very time
# consuming to produce.
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

read -p "WARNING! This will erase the compilation container. Proceed? (y/N): " -t 10 STR
if [ "$STR" == "y" ] ; then

	docker rm postgis_compilation_$(mlkp docker_image_tag)

else

	echo skipping...

fi
