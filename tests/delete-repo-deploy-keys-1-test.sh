#!/usr/bin/env roundup
#
# This file contains the test plan for the delete-repo-deploy-keys command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m github -p delete-repo-deploy-keys
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "delete-repo-deploy-keys"

it_works_with_an_existing_title() {
    KEYFILE=$(mktemp)

    rerun ssh:keygen --key-file $KEYFILE --force true
    rerun github:create-repo-deploy-key --owner rerun-modules --repository github --title $(basename ${KEYFILE}) --key-file ${KEYFILE}.pub
    rerun github:delete-repo-deploy-keys --owner rerun-modules --repository github --title $(basename ${KEYFILE})

    rm -f ${KEYFILE} ${KEYFILE}.pub
}

it_fails_with_an_non_existent_title() {
    rerun github:delete-repo-deploy-keys --owner rerun-modules --repository github --title hopefully-doesnt-exist
}
