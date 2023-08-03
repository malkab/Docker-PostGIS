#!/bin/bash

# Version: 2023-05-12

# -----------------------------------------------------------------
#
# Synchronizes arbitrary assets from S3 to local. Perform first a
# dry run (the default) to check what will be done.
#
# WARNING! Perform always a dry run first.
#
# -----------------------------------------------------------------
# Check mlkctxt to check. If void, no check will be performed. Use NOTNULL to
# enforce any context.
MATCH_MLKCTXT=default
# Target LFS bucket
TARGET_BUCKET=s3://mlk-lfs
# S3 storage class
STORAGE_CLASS=STANDARD_IA





# ---

# Check mlkctxt
if command -v mlkctxt &> /dev/null ; then

    if [ ! -z "$MATCH_MLKCTXT" ] ; then

        mlkctxtcheck $MATCH_MLKCTXT

        if [ ! $? -eq 0 ] ; then

            echo Invalid context set, required $MATCH_MLKCTXT

            exit 1

        fi

    fi

fi

# Help function
help(){
cat <<EOF
Downloads LFS data at S3 to local, check script config. By default the script
is run dry.

    ./s3-lfs-download.sh -r -h

Usage:
    -r        Perform the operation (DRYRUN false).
    -h        This help.
EOF

return 0
}

# Default values
DRYRUN=true

# Options processing
POS=0

while getopts rdh opt ; do
	case "$opt" in
    h) help
        exit 0
        ;;
    r) DRYRUN=false
        ;;
    ?) help
        exit 0
        ;;
	esac
done

# Interactive documentation, if any
if [ "$DRYRUN" = true ]; then
    DRYRUN_F="--dryrun"
else
    DRYRUN_F=
fi

# Get the project-family/project path
WP1=${PWD##*/}
cd ..
WP0=${PWD##*/}
cd $WP1
GIT_PROJECT_PATH=$WP0/$WP1

DESTINATION=$TARGET_BUCKET/$GIT_PROJECT_PATH

aws s3 sync $DRYRUN_F \
    --storage-class $STORAGE_CLASS \
    $DESTINATION .

echo
