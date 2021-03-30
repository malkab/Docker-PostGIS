#!/bin/bash

if [ "$POSTGRESGROUPID" -ne "0" ]; then

  groupadd -g $POSTGRESGROUPID postgres

fi

if [ "$POSTGRESUSERID" -ne "0" ]; then

  useradd -u $POSTGRESUSERID -m -d '/var/lib/postgresql' -g postgres postgres
  chown -R $POSTGRESUSERID:$POSTGRESGROUPID /var/lib/postgresql/
  touch /var/lib/postgresql/.psql_history

fi

if [ "$POSTGRESGROUPID" -eq "0" ]; then

  if [ "$POSTGRESUSERID" -eq "0" ]; then

    touch /root/.psql_history
    PGPASSWORD=${PASS_F} psql -h ${HOST_F} -p ${PORT_F} -U ${USER_F} ${DB_F} ${SCRIPT} ${COMMAND} ${OUTPUT_FILES_F}

  fi

fi

if [ "$POSTGRESGROUPID" -ne "0" ]; then

  if [ "$POSTGRESUSERID" -ne "0" ]; then

    PGPASSWORD=${PASS_F} exec gosu postgres psql -h ${HOST_F} -p ${PORT_F} -U ${USER_F} ${DB_F} ${SCRIPT} ${COMMAND} ${OUTPUT_FILES_F}

  fi

fi
