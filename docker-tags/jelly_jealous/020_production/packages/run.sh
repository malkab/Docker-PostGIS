#!/bin/bash

# Check if the datastore is empty
if [ -z "$(ls -A "/data/")" ] ; then

    /usr/local/bin/setup_datastore.sh

else

    echo "Datastore already exists..."

fi

echo "Starting the server..."

# Start the database
exec gosu postgres /usr/local/bin/postgres -D /data/
