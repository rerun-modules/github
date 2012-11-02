#!/usr/bin/env bash
#
#/ command: github:delete-download: ""Delete a download""
#
#/ usage: rerun github:delete-download  --file|-f <>  --owner|-o <>  --repository|-r <> [ --url|-u <https://api.github.com>] 
#
#/ variables: FILE OWNER REPOSITORY URL

# Read module function library.
. $RERUN_MODULE_DIR/lib/functions.sh || { 
  echo >&2 "Failed loading function library" ; exit 1 ; 
}

# Parse the command options.
[ -r $RERUN_MODULE_DIR/commands/delete-download/options.sh ] && {
  . $RERUN_MODULE_DIR/commands/delete-download/options.sh || exit 2 ;
}

# Exit immediately upon non-zero exit. See [set](http://ss64.com/bash/set.html)
set -e -o pipefail

# ------------------------------
# Your implementation goes here.
# ------------------------------

ID=$(curl -s ${URL}/repos/${OWNER}/${REPOSITORY}/downloads | jq -r '.[] | .name + ":" + (.id | tostring )' | grep "^$FILE:" | cut -d: -f2)
TOKEN=$(cat ~/.rerun/github.authorization | jq -r '.token')

curl -sfK - <<!
-X DELETE
--url ${URL}/repos/${OWNER}/${REPOSITORY}/downloads/${ID}?access_token=${TOKEN}
!

exit $?

# Done
