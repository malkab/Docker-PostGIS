#!/bin/bash

set -e

# Generate locale
LANG=${LOCALE}.${ENCODING}

locale-gen ${LANG} > /dev/null

echo "Locale ${LOCALE}.${ENCODING} generated"

# Check if command is just "run_default"

if [ "$1" = 'run_default' ]; then
  if [ -z "$(ls -A "/data/")" ]; then
    /usr/local/bin/setup_datastore.sh
  else
    echo "Datastore already exists..."
  fi

  echo "Starting the server..."

  # Start the database
  exec gosu postgres /usr/local/bin/postgres -D /data/
else
  echo "Executing custom command ${1}"

  exec env "$@"
fi
