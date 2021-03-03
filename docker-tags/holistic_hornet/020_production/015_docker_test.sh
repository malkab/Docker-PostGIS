#!/bin/bash

# Version 2021-03-03

# -----------------------------------------------------------------
#
# Document here the purpose of the script.
#
# -----------------------------------------------------------------
#
# Creates a container with an instance of PostgreSQL, either interactive and
# volatile or persistent in a volume.
#
# -----------------------------------------------------------------
# Check mlkcontext to check. If void, no check will be performed. If NOTNULL,
# any activated context will do, but will fail if no context was activated.
MATCH_MLKCONTEXT=common
# The network to connect to. Remember that when attaching to the network of an
# existing container (using container:name) the HOST is "localhost". Also the
# host network can be connected using just "host".
NETWORK=
# The port to expose to the host. Defaults to 5432.
PORT=
# Container identifier root. This is used for both the container name (adding an
# UID to avoid clashing) and the container host name (without UID). Incompatible
# with NETWORK container:name option. If blank, a Docker engine default name
# will be assigned to the container.
ID_ROOT=
# Unique? If true, no container with the same name can be created. Defaults to
# true.
UNIQUE=
# Declare volumes, a line per volume, complete in source:destination form. No
# strings needed, $(pwd)/../data/:/ext_src/ works perfectly. Defaults to ().
VOLUMES=
# Env vars. Use ENV_VAR_NAME_CONTAINER=ENV_VAR_NAME_HOST format. Defaults to ().
ENV_VARS=
# Run mode. Can be PERSISTABLE (-ti), VOLATILE (-ti --rm), or DAEMON (-d). If
# blank, defaults to VOLATILE.
RUN_MODE=
# The data dir can be a folder routed with $(pwd) or a name for a system-wide
# volume, or even drop it altogether for in-container data if null. This will be
# map to the /data internal folder.
PG_DATA_DIR=
# The version of PG to use. Defaults to latest.
PG_DOCKER_TAG=
# Locale. Defaults to es_ES.
LOCALE=
# postgresql.conf config, a config file that will be linked to
# /default_confs/postgresql.conf at the container. If blank, a default conf file
# will be used.
POSTGRESQL_CONF=
# pg_hba.conf config, a config file that will be linked to
# /defaults_confs/pg_hba.conf at the container. If blank, a default conf file
# will be used.
PG_HBA_CONF=
# postgres user password (postgres if blank).
PASSWORD=
# PostgreSQL user UID and GID. Defaults to 1000 and 1000.
POSTGRESUSERID=
POSTGRESGROUPID=





# ---

# Check mlkcontext is present at the system
if command -v mlkcontext &> /dev/null ; then

  if ! mlkcontext -c $MATCH_MLKCONTEXT ; then exit 1 ; fi

fi

# Manage identifier
if [ ! -z "${ID_ROOT}" ] ; then

  N="${ID_ROOT}_$(mlkcontext)"
  CONTAINER_HOST_NAME_F="--hostname ${N}"

  if [ "${UNIQUE}" = false ] ; then

    CONTAINER_NAME_F="--name ${N}_$(uuidgen)"

  else

    CONTAINER_NAME_F="--name ${N}"

  fi

fi

# Command string
if [ ! -z "${NETWORK}" ]; then NETWORK="--network=${NETWORK}" ; fi

if [ ! -z "${PG_DATA_DIR}" ]; then PG_DATA_DIR="-v ${PG_DATA_DIR}:/data/" ; fi

if [ ! -z "${POSTGRESQL_CONF}" ]; then POSTGRESQL_CONF="-v ${POSTGRESQL_CONF}:/default_confs/postgresql.conf" ; fi

if [ ! -z "${PASSWORD}" ]; then PASSWORD="-e PASSWORD=${PASSWORD}" ; fi

if [ ! -z "${PG_HBA_CONF}" ]; then PG_HBA_CONF="-v ${PG_HBA_CONF}:/default_confs/pg_hba.conf" ; fi

# Env vars
ENV_VARS_F=

if [ ! -z "${ENV_VARS}" ] ; then

  for E in "${ENV_VARS[@]}" ; do

    ARR_E=(${E//=/ })

    ENV_VARS_F="${ENV_VARS_F} -e ${ARR_E[0]}=${ARR_E[1]} "

  done

fi

# Run mode
if [ ! -z "$RUN_MODE" ] ; then

  if [ "$RUN_MODE" = "PERSISTABLE" ] ; then

    COMMAND="docker run -ti"

  elif [ "$RUN_MODE" = "VOLATILE" ] ; then

    COMMAND="docker run -ti --rm"

  elif [ "$RUN_MODE" = "DAEMON" ] ; then

    COMMAND="docker run -d"

  else

    echo Error: unrecognized RUN_MODE $RUN_MODE, exiting...
    exit 1

  fi

else

  COMMAND="docker run -ti --rm"

fi

# Volumes
VOLUMES_F=

if [ ! -z "${VOLUMES}" ] ; then

  for E in "${VOLUMES[@]}" ; do

    VOLUMES_F="${VOLUMES_F} -v ${E} "

  done

fi

# Locale
LOCALE_F=es_ES
if [ ! -z "${LOCALE}" ] ; then LOCALE_F=$LOCALE ; fi

# Port
PORT_F=5432
if [ ! -z "${PORT}" ] ; then PORT_F=$PORT ; fi

# Docker tag
PG_DOCKER_TAG_F=latest
if [ ! -z "${PG_DOCKER_TAG}" ] ; then PG_DOCKER_TAG_F=$PG_DOCKER_TAG ; fi

# UID
POSTGRESUSERID_F=1000
if [ ! -z "${POSTGRESUSERID}" ] ; then POSTGRESUSERID_F=$POSTGRESUSERID ; fi

# GID
POSTGRESGROUPID_F=1000
if [ ! -z "${POSTGRESGROUPID}" ] ; then POSTGRESGROUPID_F=$POSTGRESGROUPID ; fi

# Final command
eval    $COMMAND $INTERACTIVE \
            $NETWORK \
            $CONTAINER_NAME_F \
            $CONTAINER_HOST_NAME_F \
            $VOLUMES_F \
            $PG_DATA_DIR \
            $POSTGRESQL_CONF \
            $PG_HBA_CONF \
            $PASSWORD \
            -e "LOCALE=${LOCALE_F}" \
            -e "POSTGRESUSERID=${POSTGRESUSERID_F}" \
            -e "POSTGRESGROUPID=${POSTGRESGROUPID_F}" \
            $ENV_VARS_F \
            -p $PORT_F:5432 \
            malkab/postgis:$PG_DOCKER_TAG_F
