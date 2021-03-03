#!/bin/bash

# Gets the binaries of compilation and builds the production image

cd ../compilation/
./docker-get_binaries.sh
cd ../production

cp -R ../compilation/binaries ./packages/

docker build -t=malkab/postgis:candid_candice .

rm -Rf ./packages/binaries
