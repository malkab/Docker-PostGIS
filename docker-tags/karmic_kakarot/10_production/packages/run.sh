#!/bin/bash

# Check if the datastore is empty
if [ -d "/data/" ] ; then

    echo "Datastore already exists..."

else

    /usr/local/bin/setup_datastore.sh

fi

echo "Starting the server..."

# Start the database
exec gosu postgres /usr/local/bin/postgres -D /data/
