#!/bin/bash

# -----------------------------------------------------------------
#
# Removes the compilation image.
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

read -p "WARNING! This will remove both compilation images. Proceed? (y/N): " -t 10 STR
if [ "$STR" == "y" ] ; then

    docker rmi malkab/postgis_compilation:$(mlkp docker_image_tag)
    docker rmi malkab/postgis_compilation_final:$(mlkp docker_image_tag)

else

	echo skipping...

fi
