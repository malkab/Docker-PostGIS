#!/bin/bash

set -e

LANG=${LOCALE}.${ENCODING}

echo
echo -----------------------------
echo Configuring server...
echo -----------------------------
echo

# Check if data folder is empty. If it is, configure the dataserver
echo
echo -----------------------------
echo Initializing datastore...
echo -----------------------------
echo

# Create datastore
su postgres -c "initdb --encoding=${ENCODING} --locale=${LANG} -D /data/"

# Create log folder
echo
echo -----------------------------
echo Creating log folder...
echo -----------------------------
echo

mkdir -p /data/logs
chown postgres:postgres /data/logs

# Run the database
echo
echo -----------------------------
echo Running server for initialization...
echo -----------------------------
echo

su postgres -c "pg_ctl -w -D /data/ start"

# Alter postgres password to default
echo
echo -----------------------------
echo Setting default postgres password...
echo -----------------------------
echo

su postgres -c "psql -h localhost -p 5432 -U postgres -c \"alter role postgres password '${PASSWORD}'\""

echo
echo -----------------------------
echo Stopping server...
echo -----------------------------
echo

su postgres -c "pg_ctl -w -D /data/ stop"


# Erase default configuration and initialize it
echo
echo -----------------------------
echo Configuring pg_hba.conf...
echo -----------------------------
echo

su postgres -c "rm /data/pg_hba.conf"
su postgres -c "cp /default_confs/pg_hba.conf /data/"

# Modify basic configuration
echo
echo -----------------------------
echo Configuring postgresql.conf...
echo -----------------------------
echo

su postgres -c "rm /data/postgresql.conf"
su postgres -c "cp /default_confs/postgresql.conf /data/"


# Check if there is a /initdb.sql script to initialize database
if [ -f /initdb.sh ]; then

    echo
    echo -----------------------------
    echo Setup script found, executing...

    echo Starting server...
    echo -----------------------------
    echo

    su postgres -c "pg_ctl -w -D /data/ start"

    chmod 755 /initdb.sh

    /initdb.sh

    echo
    echo -----------------------------
    echo Stopping server...
    echo -----------------------------
    echo
    
    su postgres -c "pg_ctl -w -D /data/ stop"

fi

echo
echo -----------------------------
echo Datastore created...
echo -----------------------------
echo