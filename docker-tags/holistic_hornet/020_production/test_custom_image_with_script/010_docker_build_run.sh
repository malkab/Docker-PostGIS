#!/bin/bash

# Creates the test image and runs the test
# They are a little bit delayed, be patient

docker build -t=testpostgis-deleteme .

docker run -ti --rm \
  -p 8888:5432 \
  -v $(pwd)/../../:/ext-src \
  -v $(pwd)/data/:/data \
  -e "POSTGRESUSERID=1004" \
  -e "POSTGRESGROUPID=1009" \
  --workdir / \
  --name testpostgis-deleteme \
  testpostgis-deleteme

docker rmi testpostgis-deleteme
