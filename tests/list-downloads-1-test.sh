#!/usr/bin/env roundup
#
# This file contains the test plan for the list-downloads command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m github -p list-downloads
#

# Helpers
# ------------

rerun() {
    command $RERUN -M $RERUN_MODULES "$@"
}

# The Plan
# --------

describe "list-downloads"

it_runs_without_arguments() {
    rerun github:list-downloads -o rerun-modules -r github
}
