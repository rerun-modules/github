#!/usr/bin/env bash
#
#/ command: github:create-download: ""Create a new download""
#
#/ usage: rerun github:create-download [ --content-type|-c <application/zip>] [ --description|-d <>]  --file|-f <>  --owner|-o <>  --repository|-r <> [ --url|-u <https://api.github.com>] 
#
#/ variables: CONTENT_TYPE DESCRIPTION FILE OWNER REPOSITORY URL

# Read module function library.
. $RERUN_MODULE_DIR/lib/functions.sh || { 
  echo >&2 "Failed loading function library" ; exit 1 ; 
}

# Parse the command options.
[ -r $RERUN_MODULE_DIR/commands/create-download/options.sh ] && {
  . $RERUN_MODULE_DIR/commands/create-download/options.sh || exit 2 ;
}

# Exit immediately upon non-zero exit. See [set](http://ss64.com/bash/set.html)
set -e

# ------------------------------
# Your implementation goes here.
# ------------------------------

FILENAME=$(basename $FILE)

if [[ -z $DESCRIPTION ]]
then
  DESCRIPTION=$FILENAME
fi

SIZE=$(wc -c $FILE | awk '{print $1}')

CONTENT=$(mktemp)
RESPONSE=$(mktemp)

echo "{
  \"name\": \"$FILENAME\",
  \"size\": $SIZE,
  \"description\": \"$DESCRIPTION\",
  \"content_type\": \"$CONTENT_TYPE\"
}" > ${CONTENT}

TOKEN=$(cat ~/.rerun/github.authorization | jq -r '.token')

curl -sfK - > ${RESPONSE} <<!
-X POST
-d @${CONTENT}
--url ${URL}/repos/${OWNER}/${REPOSITORY}/downloads?access_token=${TOKEN}
!

KEY=$(cat ${RESPONSE} | jq -r '.path')
ACL=$(cat ${RESPONSE} | jq -r '.acl')
NAME=$(cat ${RESPONSE} | jq -r '.name')
ACCESSKEYID=$(cat ${RESPONSE} | jq -r '.accesskeyid')
POLICY=$(cat ${RESPONSE} | jq -r '.policy')
SIGNATURE=$(cat ${RESPONSE} | jq -r '.signature')
MIME_TYPE=$(cat ${RESPONSE} | jq -r '.mime_type')

curl -sfK - > /dev/null <<!
-F "key=${KEY}"
-F "acl=${ACL}"
-F "success_action_status=201"
-F "Filename=${NAME}"
-F "AWSAccessKeyId=${ACCESSKEYID}"
-F "Policy=${POLICY}"
-F "Signature=${SIGNATURE}"
-F "Content-Type=${MIME_TYPE}"
-F "file=@${FILE}"
--url https://github.s3.amazonaws.com/
!

rm -f ${CONTENT} ${RESPONSE}

exit $?

# Done
