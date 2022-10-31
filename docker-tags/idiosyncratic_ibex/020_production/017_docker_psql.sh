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

docker run -ti --rm \
  --name docker_postgis_test_psql \
  --network=container:docker_postgis_test \
  --user 1000:1000 \
  -v $(pwd):$(pwd) \
  --workdir $(pwd) \
  -e "HOST=localhost" \
  -e "PORT=5432" \
  -e "DB=postgres" \
  -e "USER=postgres" \
  -e "PASS=postgres" \
  --entrypoint /bin/bash \
  malkab/postgis:$(mlkp docker_image_tag) \
  -c run_psql.sh
