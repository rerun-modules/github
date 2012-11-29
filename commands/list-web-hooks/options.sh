# Generated by stubbs:add-option. Do not edit, if using stubbs.
# Created: Wed Nov 28 16:35:11 PST 2012
#
#/ usage: github:list-web-hooks  --owner <>  --repository <> [ --api-url <https://api.github.com>] [ --authorization-file <$HOME/.rerun/github.authorization>] 

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
            --owner) rerun_option_check $# ; OWNER=$2 ; shift ;;
            --repository) rerun_option_check $# ; REPOSITORY=$2 ; shift ;;
            --api-url) rerun_option_check $# ; API_URL=$2 ; shift ;;
            --authorization-file) rerun_option_check $# ; AUTHORIZATION_FILE=$2 ; shift ;;
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
    [ -z "$API_URL" ] && API_URL="https://api.github.com"
    [ -z "$AUTHORIZATION_FILE" ] && AUTHORIZATION_FILE="$HOME/.rerun/github.authorization"
    # Check required options are set
    [ -z "$OWNER" ] && { echo >&2 "missing required option: --owner" ; return 2 ; }
    [ -z "$REPOSITORY" ] && { echo >&2 "missing required option: --repository" ; return 2 ; }
    # If option variables are declared exportable, export them.

    #
    return 0
}


# Initialize the options variables to null.
OWNER=
REPOSITORY=
API_URL=
AUTHORIZATION_FILE=


