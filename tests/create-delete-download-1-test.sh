#!/usr/bin/env roundup
#
# This file contains the test plan for the create-download command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m github -p create-download
#

# Helpers
# ------------

rerun() {
    command $RERUN -M $RERUN_MODULES "$@"
}

# The Plan
# --------

describe "create-delete-download"

it_runs_without_arguments() {
    if [[ -r ~/.rerun/github.authorization ]]
    then
      touch /tmp/deleteme-1.0.0-1.noarch.rpm
      rerun github:create-download -c application/x-rpm -f /tmp/deleteme-1.0.0-1.noarch.rpm -o rerun-modules -r github
      rerun github:delete-download -f deleteme-1.0.0-1.noarch.rpm -o rerun-modules -r github
    fi
}
