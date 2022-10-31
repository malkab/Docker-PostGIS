#!/bin/bash

# How to properly use mlkctxt context check feature
# Add at top of the script:
MATCH_MLKCTXT=default

# Check mlkctxt
if command -v mlkctxt &> /dev/null ; then

  mlkctxtcheck $MATCH_MLKCTXT

  if [ ! $? -eq 0 ] ; then

    echo Invalid context set, required $MATCH_MLKCTXT

    exit 1

  fi

fi

docker login

docker push malkab/postgis:$(mlkp docker_image_tag)
