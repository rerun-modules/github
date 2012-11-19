#!/usr/bin/env roundup
#
# This file contains the test plan for the list-repo-deploy-keys command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m github -p list-repo-deploy-keys
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "list-repo-deploy-keys"

it_works_with_at_least_one_deploy_key_existing() {
    KEYFILE=$(mktemp)

    rerun ssh:keygen --key-file $KEYFILE --force true
    rerun github:create-repo-deploy-key --owner rerun-modules --repository github --title $(basename ${KEYFILE}) --key-file ${KEYFILE}.pub
    rerun github:list-repo-deploy-keys --owner rerun-modules --repository github
    rerun github:delete-repo-deploy-keys --owner rerun-modules --repository github --title $(basename ${KEYFILE})

    rm -f ${KEYFILE} ${KEYFILE}.pub
}
