#!/bin/bash

DIR=`dirname $0`

source "$DIR/utils/enviroment.sh"

require_source "display"

prepare_enviroment



create_config() {

    # $1 -- opton
    # $2 -- variable name
    # $3 -- variable value


    case "$1" in

        "init")     CREATE_CONFIG="# CONFIGURATION (`date +'%d-%m-%Y %H:%M:%S'`)\n\n"
                    ;;

        "add")      CREATE_CONFIG+="$2=$3\n"
                    echo
                    ;;

        "newline")  CREATE_CONFIG+="\n"
                    ;;

        "save")     echo -e $CREATE_CONFIG > $PATH_CONFIG
                    ;;

    esac

}


create_diary_file() {

    if [ ! -d "$DIR_DIARY" ]; then

        mkdir "$DIR_DIARY"

        echo "# GitDiary writing has begun" > $PATH_DIARY
        echo >> $PATH_DIARY
        echo `date` >> $PATH_DIARY

    fi

}


create_config_file() {

    if [ ! -f "$PATH_CONFIG" ]; then
        
        GIT_VERSION="`git --version 2>/dev/null | grep -oP '[\d\.]+'`"
        
        if [ "_$GIT_VERSION_" != "__" ]; then

            GIT_USERNAME="`git config --get user.name`"
            GIT_EMAIL="`git config --get user.email`"
        
        fi
        
        
        create_config init
        
        create_config add "GIT_VERSION"         "${GIT_VERSION:-'NOT_INSTALLED'}"
        
        create_config newline
        create_config add "GIT_USERNAME"        "${GIT_USERNAME:-'$USER'}"
        create_config add "GIT_EMAIL"           "${GIT_EMAIL:-'$USER@$HOSTNAME'}"
        create_config add "GIT_MASTER_BRANCH"   ""
        
        create_config newline
        create_config add "SSH_USERNAME"        "${GIT_USERNAME:-'$USER'}"
        create_config add "SSH_EMAIL"           "${GIT_EMAIL:-'$USER@$HOSTNAME'}"
        create_config add "SSH_FILENAME"        "${GIT_USERNAME:-'$USER'}-`date +"%Y%m%d%H%M%S"`"
        
        create_config newline
        create_config add  "APP_RUN_WITH_TEST"  1

        create_config save


    fi


    vim "$PATH_CONFIG"


    display_info "Configuration GitDiary application"

    display gray begin

    cat "$PATH_CONFIG"

    display gray end

}



#-----------------------
# SCRIPT BODY
#-----------------------

create_config_file

create_diary_file
