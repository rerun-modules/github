#!/usr/bin/env roundup
#
# This file contains the test plan for the `list-web-hooks` command.
#    
#/ usage:  rerun stubbs:test -m github -p list-web-hooks [--answers <>]
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "list-web-hooks"

it_works_with_and_without_an_existing_web_hook_url() {
  rerun github:delete-web-hook --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
  rerun github:list-web-hooks --owner rerun-modules --repository github 
  rerun github:create-web-hook --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
  rerun github:list-web-hooks --owner rerun-modules --repository github 
  rerun github:delete-web-hook --owner rerun-modules --repository github --web-hook-url "http://something.com/webhook"
}
