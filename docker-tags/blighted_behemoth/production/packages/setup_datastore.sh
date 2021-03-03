#!/bin/bash

set -e

# Generate locale
LANG=${LOCALE}.${ENCODING}

locale-gen ${LANG} > /dev/null

echo "Locale ${LOCALE}.${ENCODING} generated"

echo "Running server"

# Check if data folder is empty. If it is, configure the dataserver
echo "Initializing datastore..."

# Create datastore
su postgres -c "initdb --encoding=${ENCODING} --locale=${LANG} --lc-collate=${LANG} --lc-monetary=${LANG} --lc-numeric=${LANG} --lc-time=${LANG} -D /data/"

echo "Datastore created..."

# Create log folder
mkdir -p /data/logs
chown postgres:postgres /data/logs

echo "Log folder created..."

# Erase default configuration and initialize it
su postgres -c "rm /data/pg_hba.conf"
su postgres -c "pg_hba_conf a \"${PG_HBA}\""

# Modify basic configuration
su postgres -c "rm /data/postgresql.conf"
PG_CONF="${PG_CONF}#lc_messages='${LANG}'#lc_monetary='${LANG}'#lc_numeric='${LANG}'#lc_time='${LANG}'"
su postgres -c "postgresql_conf a \"${PG_CONF}\""

echo "Configuring and adding postgres user to the database..."

# Establish postgres user password and run the database
su postgres -c "pg_ctl -w -D /data/ start"
su postgres -c "psql -h localhost -U postgres -p 5432 -c \"alter role postgres password '${POSTGRES_PASSWD}';\""

echo "Looking for database set up script..."

# Check if there is a /initdb.sql script to initialize database
if [ -f /initdb.sh ]; then
    echo "Setup script found..."
    /initdb.sh
fi

echo "Stopping the server..."

# Stop the server
su postgres -c "pg_ctl -w -D /data/ stop"
