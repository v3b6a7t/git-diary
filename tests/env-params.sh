#!/bin/bash

source "scripts/utils/test-tools.sh"
source "scripts/utils/enviroment.sh"

unset $ANY_MODE $ALLOW_MODE $SHOW $__SHOW

TEST_PARAM_SHOW="Ala ma kota"


# TEST MODE & PARAMS

get_run_mode    "ANY_MODE"
get_run_mode    "show|delete|run-test" "ALLOW_MODE"

get_run_param   "--show"
get_run_param   "--show" "SHOW"


if [ -z "$__SHOW" ] || [ -z "$SHOW" ] || [ -z $ANY_MODE ] || [ -z $ALLOW_MODE ]; then

    ./$0 --show "Ala ma kota" --run-test

else

    test_result "any-mode"      "$ANY_MODE"
    test_result "allow-mode"    "$ALLOW_MODE"
    
    test_result "--show"        "$__SHOW"
    test_result "--show SHOW"   "$SHOW"

fi
