#!/usr/bin/env bash
#
#/ command: github:list-downloads: ""List downloads for a repository""
#
#/ usage: rerun github:list-downloads  --owner|-o <>  --repository|-r <> [ --url|-u <https://api.github.com>] 
#
#/ variables: OWNER REPOSITORY URL

# Read module function library.
. $RERUN_MODULE_DIR/lib/functions.sh || { 
  echo >&2 "Failed loading function library" ; exit 1 ; 
}

# Parse the command options.
[ -r $RERUN_MODULE_DIR/commands/list-downloads/options.sh ] && {
  . $RERUN_MODULE_DIR/commands/list-downloads/options.sh || exit 2 ;
}

# Exit immediately upon non-zero exit. See [set](http://ss64.com/bash/set.html)
set -e -o pipefail

# ------------------------------
# Your implementation goes here.
# ------------------------------

curl -sf ${URL}/repos/${OWNER}/${REPOSITORY}/downloads | jq -r '.[] | .name + " (id=" + (.id | tostring ) + ")"'

exit $?

# Done
