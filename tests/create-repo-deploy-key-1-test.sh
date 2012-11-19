#!/usr/bin/env roundup
#
# This file contains the test plan for the create-repo-deploy-key command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m github -p create-repo-deploy-key
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "create-repo-deploy-key"

it_works_with_a_new_key_file() {
    KEYFILE=$(mktemp)

    rerun ssh:keygen --key-file $KEYFILE --force true
    rerun github:create-repo-deploy-key --owner rerun-modules --repository github --title $(basename ${KEYFILE}) --key-file ${KEYFILE}.pub
    rerun github:delete-repo-deploy-keys --owner rerun-modules --repository github --title $(basename ${KEYFILE})

    rm -f ${KEYFILE} ${KEYFILE}.pub
}

it_fails_with_an_existing_key_file() {
    KEYFILE=$(mktemp)

    rerun ssh:keygen --key-file $KEYFILE --force true
    rerun github:create-repo-deploy-key --owner rerun-modules --repository github --title $(basename ${KEYFILE}) --key-file ${KEYFILE}.pub

    if ! rerun github:create-repo-deploy-key --owner rerun-modules --repository github --title $(basename ${KEYFILE}) --key-file ${KEYFILE}.pub
    then
      :
    fi

    rerun github:delete-repo-deploy-keys --owner rerun-modules --repository github --title $(basename ${KEYFILE})

    rm -f ${KEYFILE} ${KEYFILE}.pub
}

# ------------------------------

