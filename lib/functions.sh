# Shell functions for the foo module.
#/ usage: source RERUN_MODULE_DIR/lib/functions.sh command
#

# Read rerun's public functions
. $RERUN || {
    echo >&2 "ERROR: Failed sourcing rerun function library: \"$RERUN\""
    return 1
}

# Check usage. Argument should be command name.
[[ $# = 1 ]] || rerun_option_usage

# Source the option parser script.
#
if [[ -r $RERUN_MODULE_DIR/commands/$1/options.sh ]] 
then
    . $RERUN_MODULE_DIR/commands/$1/options.sh || {
        rerun_die "Failed loading options parser."
    }
fi

# - - -
# Your functions declared here.
# - - -

# Use Curl to call the GitHub API.

curl_github_api() {
  # Check and assign options.
  [[ ! $# -eq 4 && ! $# -eq 5 && ! $# -eq 7 ]] && rerun_die 'usage: \"curl_github_api authorization-file api-url request-method call [content-file] [username] [password]\"'
  local AUTHORIZATION_FILE=$1
  local API_URL=$2
  local REQUEST_METHOD=$3
  local CALL=$4

  if [[ $# -eq 4 && ${REQUEST_METHOD} = "POST" ]]
  then
    rerun_die "the content-file is required for POST requests"
  fi

  if [[ ( $# -eq 4 || $# -eq 5 )  && ${REQUEST_METHOD} = "AUTH" ]]
  then
    rerun_die "content-file, username and password are required for AUTH requests"
  fi

  if [[ $# -eq 5 ]]
  then
    local CONTENT=$5

    if [[ ${REQUEST_METHOD} != "POST" ]]
    then
      rerun_die "the content-file is only required for POST requests"
    fi
  fi

  if [[ $# -eq 7 ]]
  then
    local CONTENT=$5
    local USERNAME=$6
    local PASSWORD=$7

    if [[ ${REQUEST_METHOD} != "AUTH" ]]
    then
      rerun_die "the content-file, username and password are only required for AUTH requests"
    fi
  fi

  # Get the authorization token if doing anything other than an authorization call.
  if [[ ${REQUEST_METHOD} != "AUTH" ]]
  then
    [[ -e ${AUTHORIZATION_FILE} ]] || rerun_die "\"${AUTHORIZATION_FILE}\": no such file or directory. use \"rerun github:get-authorization-token\"."
    local TOKEN=$(cat ${AUTHORIZATION_FILE} | jq -r '.token')

    if [[ -z ${TOKEN} ]]
    then
      rerun_die "couldn't get token from \"${AUTHORIZATION_FILE}\"."
    fi
  fi

  # Prepare to process the API response.
  local RESPONSE=$(mktemp)

  # Call curl in silent mode (-s) to eliminate distracting output, following redirects (-L), and with arguments supplied from standard input (-K and the "here" script) to avoid leaking sensitive information into the process table. Append the HTTP code to the response to aid error checking.
  case ${REQUEST_METHOD} in
    "AUTH")
      curl -w "%{http_code}\\n" -sLK - > ${RESPONSE} <<EOF
-X POST
-u ${USERNAME}:${PASSWORD}
-d @${CONTENT}
--url ${API_URL}${CALL}
EOF
    ;;

    "POST")
      curl -w "%{http_code}\\n" -sLK - > ${RESPONSE} <<EOF
-X ${REQUEST_METHOD}
-d @${CONTENT}
--url ${API_URL}${CALL}?access_token=${TOKEN}
EOF
    ;;

    *)
      curl -w "%{http_code}\\n" -sLK - > ${RESPONSE} <<EOF
-X ${REQUEST_METHOD}
--url ${API_URL}${CALL}?access_token=${TOKEN}
EOF
    ;;
  esac

  # Check the status code:
  local STATUS=$(tail -1 ${RESPONSE})
  [[ ${STATUS} -eq 422 ]] && rerun_die "${STATUS}: $(cat ${RESPONSE} | sed '$d' | jq -r '.errors | .[] | .message';rm -f ${RESPONSE})"
  [[ ${STATUS} -ge 400 && ${STATUS} -lt 499 ]] && rerun_die "${STATUS}: $(cat ${RESPONSE} | sed '$d' | jq -r '.message';rm -f ${RESPONSE})"

  # Print the response data without the last line.
  sed '$d' < ${RESPONSE}

  # Cleanup.
  rm -f ${RESPONSE}

  return 0
}
