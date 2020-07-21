#!/bin/bash

source "scripts/utils/test-tools.sh"
source "scripts/utils/enviroment.sh"


# COMPONENT TESTING

do_require_test "config"    "GIT_USERNAME"
do_require_test "display"   "DISPLAY_INFO_BEGIN" 
