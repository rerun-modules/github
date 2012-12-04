#!/usr/bin/env roundup
#
# This file contains the test plan for the `create-web-hook` command.
#    
#/ usage:  rerun stubbs:test -m github -p create-web-hook [--answers <>]
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "create-web-hook"

it_works_with_a_new_and_an_existing_web_hook_url() {
  rerun github:delete-web-hook --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
  rerun github:create-web-hook --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
  rerun github:create-web-hook --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
  rerun github:delete-web-hook --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
}

it_works_with_replace() {
  rerun github:delete-web-hook --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
  rerun github:create-web-hook --replace true --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
  rerun github:create-web-hook --replace true --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
  rerun github:delete-web-hook --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
}
