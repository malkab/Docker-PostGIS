#!/bin/bash

# Execs a bash into the test container

docker exec -ti \
    testpostgis-deleteme \
    /bin/bash
