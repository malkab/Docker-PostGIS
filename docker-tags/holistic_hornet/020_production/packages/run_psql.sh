#!/bin/bash

PGPASSWORD=${PASS_F} exec gosu $(id -un $POSTGRESUSERID) psql -h ${HOST_F} -p ${PORT_F} -U ${USER_F} ${DB_F} ${SCRIPT} ${COMMAND} ${OUTPUT_FILES_F}
