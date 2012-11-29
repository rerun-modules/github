# Generated by stubbs:add-option. Do not edit, if using stubbs.
# Created: Wed Nov 28 15:52:57 PST 2012
#
#/ usage: github:list-organization-repositories  --organization <> [ --authorization-file <$HOME/.rerun/github.authorization>] [ --api-url <https://api.github.com>] 

# _rerun_options_parse_ - Parse the command arguments and set option variables.
#
#     rerun_options_parse "$@"
#
# Arguments:
#
# * the command options and their arguments
#
# Notes:
# 
# * Sets shell variables for any parsed options.
# * The "-?" help argument prints command usage and will exit 2.
# * Return 0 for successful option parse.
#
rerun_options_parse() {
    
    while [ "$#" -gt 0 ]; do
        OPT="$1"
        case "$OPT" in
            --organization) rerun_option_check $# ; ORGANIZATION=$2 ; shift ;;
            --authorization-file) rerun_option_check $# ; AUTHORIZATION_FILE=$2 ; shift ;;
            --api-url) rerun_option_check $# ; API_URL=$2 ; shift ;;
            # help option
            -?)
                rerun_option_usage
                exit 2
                ;;
            # end of options, just arguments left
            *)
              break
        esac
        shift
    done

    # Set defaultable options.
    [ -z "$AUTHORIZATION_FILE" ] && AUTHORIZATION_FILE="$HOME/.rerun/github.authorization"
    [ -z "$API_URL" ] && API_URL="https://api.github.com"
    # Check required options are set
    [ -z "$ORGANIZATION" ] && { echo >&2 "missing required option: --organization" ; return 2 ; }
    # If option variables are declared exportable, export them.

    #
    return 0
}


# Initialize the options variables to null.
ORGANIZATION=
AUTHORIZATION_FILE=
API_URL=


