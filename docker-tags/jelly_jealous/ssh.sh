#!/bin/bash

# Version: 2022-07-08

# -----------------------------------------------------------------
#
# Document purpose of script here.
#
# -----------------------------------------------------------------
#
# SSH to a host.
#
# -----------------------------------------------------------------
# Check mlkctxt to check. If void, no check will be performed. Use NOTNULL to
# enforce any context.
MATCH_MLKCTXT=NOTNULL
# Remote SSH username. Mandatory.
USER=$(mlkp ssh.user)
# Host. Mandatory.
HOST=$(mlkp ssh.host)
# SSH port. Defaults to 22.
PORT=$(mlkp ssh.port)
# Amazon AWS PEM key (it´s a path to a file, or blank if not applicable).
AWS_PEM=$(mlkp ssh.pem)





# ---

# Check mlkctxt
if command -v mlkctxt &> /dev/null ; then

    mlkctxtcheck $MATCH_MLKCTXT

    if [ ! $? -eq 0 ] ; then

      echo Invalid context set, required $MATCH_MLKCTXT

      exit 1

    fi

fi

# User
if [ -z $USER ] ; then

    echo USER is mandatory, exiting...
    exit 1

fi

# User
if [ -z $HOST ] ; then

    echo HOST is mandatory, exiting...
    exit 1

fi

# Port
PORT_F=22
if [ ! -z "${PORT}" ] ; then PORT_F=$PORT ; fi

# Amazon PEM
if [ ! -z $AWS_PEM ] ; then

    RSH_OPTIONS="-i ${AWS_PEM} -p ${PORT_F}"

else

    RSH_OPTIONS="-p ${PORT_F}"

fi

# The command
SSH="ssh ${RSH_OPTIONS} "

# Command
COMMAND="${SSH} ${USER}@${HOST}"

# eval $COMMAND
eval $COMMAND
