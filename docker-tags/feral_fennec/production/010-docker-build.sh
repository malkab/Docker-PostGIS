#!/bin/bash

. ../env.env

# Gets the binaries of compilation and builds the production image

cd ../compilation/

./docker-get_binaries.sh

cd ../production

cp -R ../compilation/binaries ./packages/

docker build -t=malkab/postgis:$DOCKER_IMAGE_TAG .

rm -Rf ./packages/binaries
