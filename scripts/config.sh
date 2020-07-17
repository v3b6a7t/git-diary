#!/bin/bash

DIR=`dirname $0`

source "$DIR/utils/enviroment.sh"

require_source "display"

prepare_enviroment


if [ ! -d "$DIR_DIARY" ]; then
    mkdir "$DIR_DIARY"

    echo "# GitDiary writing has begun" > $PATH_DIARY
    echo >> $PATH_DIARY
    echo `date` >> $PATH_DIARY
fi


if [ ! -d "$DIR_SSH" ]; then

    mkdir "$DIR_SSH"

fi


if [ ! -d "$DIR_CONFIG" ]; then

    mkdir "$DIR_CONFIG"

fi


if [ ! -f "$PATH_CONFIG" ]; then
    
    GIT_VERSION="`git --version 2>/dev/null | grep -oP '[\d\.]+'`"
    
    if [ "_$GIT_VERSION_" != "__" ]; then

        GIT_USERNAME="`git config --get user.name`"
        GIT_EMAIL="`git config --get user.email`"
    
    fi
    
    echo "# CONFIGURATION (`date +'%d-%m-%Y %H:%M:%S'`)" > $PATH_CONFIG
    
    echo >> $PATH_CONFIG
    echo "GIT_VERSION=${GIT_VERSION:-'NOT_INSTALLED'}" >> $PATH_CONFIG
    echo "GIT_USERNAME=${GIT_USERNAME:-'$USER'}" >> $PATH_CONFIG
    echo "GIT_EMAIL=${GIT_EMAIL:-'$USER@$HOSTNAME'}" >> $PATH_CONFIG
    
    echo >> $PATH_CONFIG
    echo "SSH_USERNAME=${GIT_USERNAME:-'$USER'}" >> $PATH_CONFIG
    echo "SSH_EMAIL=${GIT_EMAIL:-'$USER@$HOSTNAME'}" >> $PATH_CONFIG
    echo "SSH_FILENAME=${GIT_USERNAME:-'$USER'}-`date +"%Y%m%d%H%M%S"`" >> $PATH_CONFIG

    echo >> $PATH_CONFIG
    echo "APP_RUN_WITH_TEST=1" >> $PATH_CONFIG


fi


vim "$PATH_CONFIG"


display_info "Configuration GitDiary application"

display gray begin

cat "$PATH_CONFIG"

display gray end
