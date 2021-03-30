#!/bin/bash

# Creation of postgres user and group
mkdir -p /var/lib/postgresql
groupadd -g $POSTGRESGROUPID postgres
useradd -u $POSTGRESUSERID -m -d '/var/lib/postgresql' -g postgres postgres
