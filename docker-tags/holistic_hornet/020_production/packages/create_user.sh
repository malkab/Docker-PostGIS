#!/bin/bash

# Creation of postgres user and group
mkdir -p /var/lib/postgresql
groupadd -g $POSTGRESGROUPID postgres
useradd -u $POSTGRESUSERID --home '/var/lib/postgresql' -g postgres postgres
