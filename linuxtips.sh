#!/bin/bash

config_file_path="/etc/tip-of-the-day/config.sh"

while getopts 'edoh:' OPTION; do
    case "$OPTION" in
        e)
            nano $config_file_path;;

        d)
            user=$(whoami)
            source $config_file_path
            read -r -a disabled_users <<< "$DISABLED_USERS"

            if [[ ! " ${disabled_users[*]} " =~ " ${user} " ]]; then
                sed -i "/^DISABLED_USERS=/ s/\"\([^']*\)\"/\"${user}\"/" $config_file_path
            fi;;

        o)
            user=$(whoami)
            source $config_file_path
            read -r -a disabled_users <<< "$DISABLED_USERS"

            if [[ " ${disabled_users[*]} " =~ " ${user} " ]]; then
                sed -i "s/${user}//" $config_file_path
            fi;;

        h)
            echo "linuxtips -e to edit configuaration file. -d Disable tips for current user. -o Enable tips back for the current user.";;

        \?)
        echo "-h to get help." >&2
        exit 1
        ;;
    esac
done
shift $((OPTIND-1))
