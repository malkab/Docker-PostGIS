#!/bin/bash

# Version: 2021-03-03

# -----------------------------------------------------------------
#
# Push images.
#
# -----------------------------------------------------------------
#
# Pushes images to the GitLab registry with confirmation.
#
# -----------------------------------------------------------------
# Check mlkctxt to check. If void, no check will be performed. If NOTNULL,
# any activated context will do, but will fail if no context was activated.
MATCH_MLKCTXT=
# A set of images to upload, in the form (image0 image1). Could be multiline
# inside the parentheses. Provide the full image names as shown in docker
# images. This parameter is mandatory.
IMAGES=(
  malkab/postgis:holistic_hornet
  malkab/postgis:latest
)
# The user for login. Leave blank if the default DockerHub repo is going to be
# used.
USER=
# The registry for login. Leave blank if the default DockerHub repo is going to
# be used.
REGISTRY=





# ---

# Check mlkctxt is present at the system
if command -v mlkctxt &> /dev/null ; then

  if ! mlkctxt -c $MATCH_MLKCTXT ; then exit 1 ; fi

fi

if [ ${#IMAGES[@]} == 0 ]; then

  echo "No images defined, exiting..."

  exit 1

fi

if [ ! -z "${USER}" ] ; then

  echo Please provide registry credentials, if GitLab, this implies an API token...

  docker login $REGISTRY -u $USER

fi

for IMAGE in "${IMAGES[@]}" ; do

  echo -------------
  echo PUSHING IMAGE ${IMAGE}
  echo -------------
  docker push $IMAGE

done
