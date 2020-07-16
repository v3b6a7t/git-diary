#!/bin/bash

DIR=`dirname $0`

source "$DIR/utils/display.sh"


if [ ! -f "$DIR/config/config.conf" ]; then 
    display_warning "Configuration file does not exist"; echo
    exit 0
else 
    source "$DIR/config/config.conf"
fi



if [ "_$DIR_SSH_" != "__" ] & [ "_$SSH_EMAIL_" != "__" ] & [ "_$SSH_FILENAME_" != "__" ]; then

    KEY_FILENAME="$DIR_SSH/$SSH_FILENAME";

    SSH_MODE=`echo $@ | grep -oP "\-{2}\w+"`
    SSH_MODE=${SSH_MODE:2}

    if [ "$SSH_MODE" = "clip" ]; then
        vim "$KEY_FILENAME.pub"
        exit 1
    fi


    if [ "$SSH_MODE" = "delete" ]; then
        if [ `ssh-add -l | grep "$KEY_FILENAME" -c` -gt 0 ]; then
            ssh-add -d "$KEY_FILENAME.pub"
            display_info "The SSH key '$SSH_FILENAME' has been removed from the Autentication Agent"; echo
        fi

        if [ ! `ssh-add -l | grep "$KEY_FILENAME" -c` -gt 0 ] & [ -f "$KEY_FILENAME" ]; then 
            rm $KEY_FILENAME*
            display_info "The SSH key '$SSH_FILENAME' has been removed from the storage"; echo
        fi 
        exit 1
    fi


    if [ ! -f "$KEY_FILENAME" ]; then

        display info begin
        echo " An SSH key will be generated "
        echo " please enter a strong password "
        display info end

        ssh-keygen -t rsa -b 4096 -C "$SSH_EMAIL" -f "$KEY_FILENAME"

        if [ -f "$KEY_FILENAME" ]; then
        
            display info begin
            echo " The private key will be added "
            echo " to the SSH Authentication Agent "
            echo " Enter your password "
            display info end

            ssh-add "$KEY_FILENAME"
        fi

    else
        display_info "SSH key '$SSH_FILENAME' already exists"; echo
    fi

fi
