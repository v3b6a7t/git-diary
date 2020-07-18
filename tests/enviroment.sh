#!/bin/bash

source "scripts/utils/test-tools.sh"
source "scripts/utils/enviroment.sh"


# COMPONENT TESTING

do_require_test "config"    "GIT_USERNAME"
do_require_test "display"   "DISPLAY_INFO_BEGIN" 

get_current_branch  "CURRENT_BRANCH"
get_master_branch   "MASTER_BRANCH"

test_result "CURRENT_BRANCH" $CURRENT_BRANCH
test_result "MASTER_BRANCH" $MASTER_BRANCH
