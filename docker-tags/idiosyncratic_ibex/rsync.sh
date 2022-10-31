#!/bin/bash

# Version: 2022-07-08

# -----------------------------------------------------------------
#
# Describe script purpose here.
#
# -----------------------------------------------------------------
#
# Push assets to a remote host. Be VERY CAREFULL with the --delete option!!!
# Terrible data loss has happen in the past.
#
# -----------------------------------------------------------------
# Check mlkctxt to check. If void, no check will be performed. Use NOTNULL to
# enforce any context.
MATCH_MLKCTXT=NOTNULL
# Source and destination folder, can be as simple as . or as complex as an
# user@host:/path. Mandatory both.
SOURCE_FOLDER=.
DESTIN_FOLDER=$(mlkp ssh.user)@$(mlkp ssh.host):$(mlkp ssh.remote_folder)
# Excludes, for example ("a*" "e*" "r*"). Defaults to some commonly excluded
# files: ".DS_Store rsync*" ".gitignore" ".git" "*.mlkctxt_template"
EXCLUDES=(
  .DS_Store rsync*
  .gitignore
  .git
  *.mlkctxt_template
  ssh*
  mlkctxt
  README.md
)
# SSH port. Defaults to 22.
PORT=$(mlkp ssh.port)
# Amazon AWS PEM key (it´s a path to a file, or blank if none).
AWS_PEM=$(mlkp ssh.pem)

# Make install script runable
chmod 755 *.sh



# ---

# Check mlkctxt
if command -v mlkctxt &> /dev/null ; then

  mlkctxtcheck $MATCH_MLKCTXT

  if [ ! $? -eq 0 ] ; then

    echo Invalid context set, required $MATCH_MLKCTXT

    exit 1

  fi

fi

# Check folders
if [ -z $SOURCE_FOLDER ] ; then
  echo SOURCE_FOLDER is mandatory, exiting...
  exit 1
fi

if [ -z $DESTIN_FOLDER ] ; then
  echo DESTIN_FOLDER is mandatory, exiting...
  exit 1
fi

# By default, run dry and without delete
DRY_RUN=true
DELETE=false

# Help function
help(){
cat <<EOF
rsync.sh to a remote host, configure the script for details.

    ./rsync.sh [-r] [-d]

Usage:
    -r    run the command, by default, the command is run dry
    -d    enable delete mode, both for dry and run modes
EOF

return 0
}

# Check options
while getopts :rdh opt
do
	case "$opt" in
    r) DRY_RUN=false
       ;;
    d) DELETE=true
       ;;
    h) help
       exit 0
       ;;
    ?) help
       exit 0
       ;;
	esac
done

# Initial options for SSH and RSYNC
PORT_F=22
if [ ! -z "${PORT}" ] ; then PORT_F=$PORT ; fi
SSH_OPTIONS="-p ${PORT_F}"

# Excludes
EXCLUDES_F=(".DS_Store" "rsync*" ".gitignore" ".git" "*.mlkctxt_template")
if [ ! -z "${EXCLUDES}" ] ; then EXCLUDES_F=( "${EXCLUDES[@]}" ) ; fi

# Amazon PEM
if [ ! -z $AWS_PEM ] ; then
  SSH_OPTIONS="${SSH_OPTIONS} -i ${AWS_PEM}"
fi

# BEWARE THE DELETE!!!
if [ "$DELETE" = true ] ; then
  DELETE="--delete"
else
  DELETE=""
fi

# Dry run
if [ "$DRY_RUN" = true ] ; then
  DRY_RUN_F="--dry-run"
else
  DRY_RUN_F=""
fi

# The command
RSYNC="rsync -avzhr --progress ${DELETE} ${DRY_RUN_F} --rsh=\"ssh ${SSH_OPTIONS}\" "

# Process of excludes
for EXCLUDE in "${EXCLUDES_F[@]}" ; do
  RSYNC="${RSYNC} --exclude \"${EXCLUDE}\""
done

# Command
RSYNC="${RSYNC} ${SOURCE_FOLDER} ${DESTIN_FOLDER}"
eval $RSYNC

# Inform the user
if [ "$DRY_RUN" = true ] ; then
  echo "NOTE: this was a dry run"
fi

if [ "$DELETE" = "--delete" ] ; then
  echo "WARNING!: this was a delete run"
fi
