#!/usr/bin/env bash
#
#/ command: github:get-authorization-token: ""Get an authorization token to access the API""
#
#/ usage: rerun github:get-authorization-token [ --url|-u <https://api.github.com>] 
#
#/ variables: URL

# Read module function library.
. $RERUN_MODULE_DIR/lib/functions.sh || { 
  echo >&2 "Failed loading function library" ; exit 1 ; 
}

# Parse the command options.
[ -r $RERUN_MODULE_DIR/commands/get-authorization-token/options.sh ] && {
  . $RERUN_MODULE_DIR/commands/get-authorization-token/options.sh || exit 2 ;
}

# Exit immediately upon non-zero exit. See [set](http://ss64.com/bash/set.html)
set -e -o pipefail

# ------------------------------
# Your implementation goes here.
# ------------------------------

read -rp "username: " USERNAME
read -rsp "password: " PASSWORD
echo

mkdir -p $HOME/.rerun

CONTENT=$(mktemp)
sed -e "s/\${LOGNAME}/${LOGNAME}/" -e "s/\${HOSTNAME}/${HOSTNAME}/" $RERUN_MODULE_DIR/templates/authorizations.json > ${CONTENT}

touch $HOME/.rerun/github.authorization
chmod 600 $HOME/.rerun/github.authorization

curl -sfK - > $HOME/.rerun/github.authorization <<!
-f
-X POST
-u ${USERNAME}:${PASSWORD}
-d @${CONTENT}
--url $URL/authorizations <<!
!

rm -f ${CONTENT}

exit $?

# Done
