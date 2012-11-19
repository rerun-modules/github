# Generated by stubbs:add-option. Do not edit, if using stubbs.
# Created: Sun Nov 18 16:12:07 PST 2012
#
#/ usage: github:delete-repo-deploy-keys  --url <https://api.github.com>  --owner <>  --repository <> [ --title <$USER@$HOSTNAME>] 

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
            --url) rerun_option_check $# ; URL=$2 ; shift ;;
            --owner) rerun_option_check $# ; OWNER=$2 ; shift ;;
            --repository) rerun_option_check $# ; REPOSITORY=$2 ; shift ;;
            --title) rerun_option_check $# ; TITLE=$2 ; shift ;;
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
    [ -z "$URL" ] && URL="https://api.github.com"
    [ -z "$TITLE" ] && TITLE="$USER@$HOSTNAME"
    # Check required options are set
    [ -z "$URL" ] && { echo >&2 "missing required option: --url" ; return 2 ; }
    [ -z "$OWNER" ] && { echo >&2 "missing required option: --owner" ; return 2 ; }
    [ -z "$REPOSITORY" ] && { echo >&2 "missing required option: --repository" ; return 2 ; }
    # If option variables are declared exportable, export them.

    #
    return 0
}


# Initialize the options variables to null.
URL=
OWNER=
REPOSITORY=
TITLE=

