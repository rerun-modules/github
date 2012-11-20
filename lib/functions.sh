# 
# Shell functions for @MODULE@ commands
#


# Read rerun's public functions
. $RERUN || {
    echo >&2 "ERROR: Failed sourcing rerun function library: \"$RERUN\""
    return 1
}


# ----------------------------
# Your functions declared here.
#

# Use Curl to call the GitHub API.

githubCurlAPI() {
  # Check and assign options.
  [[ ! $# -eq 4 ]] && rerun_die 'usage: \"githubCurlAPI authorization-file api-url request-method call\"'
  local AUTHORIZATION_FILE=$1
  local API_URL=$2
  local REQUEST_METHOD=$3
  local CALL=$4

  # Get the authorization token.
  [[ -e ${AUTHORIZATION_FILE} ]] || rerun_die "\"${AUTHORIZATION_FILE}\": no such file or directory. use \"rerun github:get-authorization-token\"."
  local TOKEN=$(cat ${AUTHORIZATION_FILE} | jq -r '.token')

  # Prepare to process the API response.
  local RESPONSE=$(mktemp)
  echo -e "{\n\"response\" : \c" > ${RESPONSE}

  # Call curl in silent mode (-s) to eliminate distracting output, following redirects (-L), and with arguments supplied from standard input (-K and the "here" script) to avoid leaking sensitive information into the process table.
  curl -w ",\"status\": %{http_code}\\n}\\n" -sLK - >> ${RESPONSE} <<EOF
-X ${REQUEST_METHOD}
--url ${API_URL}${CALL}?access_token=${TOKEN}
EOF

  # Check the status code:
  local STATUS=$(cat $RESPONSE | jq -r '.status')
  [[ ${STATUS} -ge 400 && ${STATUS} -lt 499 ]] && rerun_die "${STATUS}: $(cat ${RESPONSE} | jq -r '.response | .message';rm -f ${RESPONSE})"

  # Return the result.
  cat ${RESPONSE}

  # Cleanup.
  rm -f ${RESPONSE}

  return 0
}
