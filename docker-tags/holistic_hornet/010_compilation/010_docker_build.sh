#!/bin/bash

# Version: 2021-03-03

# -----------------------------------------------------------------
#
# Builds the compilation image from all code bases. This image will the base for
# creating the production one.
#
# -----------------------------------------------------------------
#
# Builds a Docker image.
#
# -----------------------------------------------------------------
# Check mlkctxt to check. If void, no check will be performed. If NOTNULL,
# any activated context will do, but will fail if no context was activated.
MATCH_MLKCTXT=common
# The name of the image to build. Mandatory.
IMAGE_NAME=malkab/postgis_compilation
# The tags. An array of tags in the form (tagA tagB) to create as many images
# as tags. Defaults to (latest).
IMAGE_TAGS=(holistic_hornet)
# Dockerfile.
DOCKERFILE=.
# Build args, an array of (ARG_NAME=ARG_VALUE ARG_NAME=ARG_VALUE) structure
# to add --build-arg parameters to the build. Defaults to ().
BUILD_ARGS=(
  PG_VERSION=$MLKC_PG_VERSION
  GEOS_VERSION=$MLKC_GEOS_VERSION
  PROJ_VERSION=$MLKC_PROJ_VERSION
  GDAL_VERSION=$MLKC_GDAL_VERSION
  POSTGIS_VERSION=$MLKC_POSTGIS_VERSION
)





# ---

# Check mlkctxt is present at the system
if command -v mlkctxt &> /dev/null
then

  if ! mlkctxt -c $MATCH_MLKCTXT ; then exit 1; fi

fi

# Process tags
IMAGE_TAGS_F=(latest)

if [ ! -z "$IMAGE_TAGS" ] ; then IMAGE_TAGS_F=("${IMAGE_TAGS[@]}") ; fi

# Build the image with the firts image tag, removing it
FIRST_TAG=${IMAGE_TAGS_F[0]}
IMAGE_TAGS_F_REST=("${IMAGE_TAGS_F[@]:1}")

# Add build-args
BUILD_ARGS_F=

if [ ! -z "${BUILD_ARGS}" ] ; then

  for E in "${BUILD_ARGS[@]}" ; do

    ARR_E=(${E//=/ })

    BUILD_ARGS_F="${BUILD_ARGS_F} --build-arg ${ARR_E[0]}=${ARR_E[1]} "

  done

fi

echo "BUILDING BASE IMAGE WITH FIRST TAG: ${IMAGE_NAME}:${FIRST_TAG}"
echo -------------

# Build
docker build $BUILD_ARGS_F -t $IMAGE_NAME:$FIRST_TAG $DOCKERFILE

# Tag remaining ones
for T in "${IMAGE_TAGS_F_REST[@]}" ; do

  docker tag $IMAGE_NAME:$FIRST_TAG $IMAGE_NAME:$T

done
