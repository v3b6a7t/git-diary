#!/bin/bash

source "scripts/utils/test-tools.sh"
source "scripts/utils/enviroment.sh"

# CONFIG FUNCTION TESTING

get_config_value    "GIT_VERSION"
test_result         "GIT_VERSION" "$GIT_VERSION"



# GIT FUNCTIONS TESTING

get_current_branch  "CURRENT_BRANCH"
get_master_branch   "MASTER_BRANCH"

test_result         "CURRENT_BRANCH" "$CURRENT_BRANCH"
test_result         "MASTER_BRANCH" "$MASTER_BRANCH"
