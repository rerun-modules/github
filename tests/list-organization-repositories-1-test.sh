#!/usr/bin/env roundup
#
# This file contains the test plan for the list-organization-repositories command.
# Execute the plan by invoking: 
#    
#     rerun stubbs:test -m github -p list-organization-repositories
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "list-organization-repositories"

it_fails_without_options() {
  if ! rerun github:list-organization-repositories
  then
    :
  fi
}

it_works_with_a_valid_organization() {
  rerun github:list-organization-repositories --organization rerun-modules
}

it_fails_with_an_invalid_organization() {
  if ! rerun github:list-organization-repositories --organization hopefully-invalid-organization
  then
    :
  fi
}
