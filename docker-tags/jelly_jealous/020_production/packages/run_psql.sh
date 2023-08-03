#!/bin/bash

# Runs a psql session based on the ENV VARS passed to Docker

PGPASSWORD=${PASS} psql \
    -h ${HOST} \
    -p ${PORT} \
    -U ${USER} \
    ${DB} ${SCRIPT} ${COMMAND} ${OUTPUT_FILES}
