#!/bin/bash

source "scripts/utils/test-tools.sh"
source "scripts/utils/enviroment.sh"


# TEST MODE

get_run_mode    "ANY_MODE"
test_result     "ANY_MODE"  "$ANY_MODE"

get_run_mode    "run-test|show|delete"  "ALLOW_MODE"
test_result     "ALLOW_MODE" "$ALLOW_MODE"


# TEST PARAMS

get_run_param   "--show"
test_result     "SHOW"    "$__SHOW"

get_run_param   "--message" "MESSAGE"
test_result     "MESSAGE"   "$MESSAGE"
