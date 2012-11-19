#!/usr/bin/env roundup
#
# This file contains the test plan for the create-download command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m github -p create-download
#

# The Plan
# --------

describe "create-delete-download"

it_runs_without_arguments() {
    if [[ -r ~/.rerun/github.authorization ]]
    then
      TMPDIR=$(mktemp -d)
      touch ${TMPDIR}/deleteme-1.0.0-1.noarch.rpm
      rerun github:create-download -c application/x-rpm -f ${TMPDIR}/deleteme-1.0.0-1.noarch.rpm -o rerun-modules -r github
      rerun github:delete-download --file deleteme-1.0.0-1.noarch.rpm --owner rerun-modules --repository github
      rm -rf ${TMPDIR}
    fi
}
