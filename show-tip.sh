#!/bin/bash

config_file_path="/etc/tip-of-the-day/config.sh"

show_next () {
    clear

    source $config_file_path
    read -r -a SKIP_ARRAY <<< "$SKIP"
    number=$1

    while [[ " ${SKIP_ARRAY[*]} " =~ " ${number} " ]]
    do
        if [ "$number" -lt $TOTAL_TIPS ]; then
                t=$(($number + 1))
                number=$t
                sed -i "s/NEXT_TIP=.*/NEXT_TIP=$t/" $config_file_path
        else
            sed -i "s/NEXT_TIP=.*/NEXT_TIP=1/" $config_file_path
        fi
        source $config_file_path
    done

    source $config_file_path
    cat $TIPS_PATH/$number.txt

    if [ "$number" -lt $TOTAL_TIPS ]; then
        t=$(($number + 1))
        sed -i "s/NEXT_TIP=.*/NEXT_TIP=$t/" $config_file_path
    else
        sed -i "s/NEXT_TIP=.*/NEXT_TIP=1/" $config_file_path
    fi
}

show_previous () {
    clear

    source $config_file_path
    read -r -a SKIP_ARRAY <<< "$SKIP"
    number=$1

    while [[ " ${SKIP_ARRAY[*]} " =~ " ${number} " ]]
    do
        if [ "$number" -gt 1 ]; then
            t=$(($number - 1))
            number=$t
            sed -i "s/NEXT_TIP=.*/NEXT_TIP=$t/" $config_file_path
        else
            sed -i "s/NEXT_TIP=.*/NEXT_TIP=$TOTAL_TIPS/" $config_file_path
        fi
        source $config_file_path
    done

    source $config_file_path
    cat $TIPS_PATH/$number.txt

    if [ "$number" -gt 1 ]; then
        t=$(($number - 0))
        sed -i "s/NEXT_TIP=.*/NEXT_TIP=$t/" $config_file_path
    else
        sed -i "s/NEXT_TIP=.*/NEXT_TIP=10/" $config_file_path
    fi
}

is_left () {
    source $config_file_path
    files=$(ls $TIPS_PATH)

    read -r -a skipArray <<< "$(echo $files | sed 's/\.txt//g')"
    sortedArray=($(echo "${skipArray[*]}" | tr ' ' '\n' | sort -n))
    sortedString=$(echo "${sortedArray[*]}" | tr ' ' '\n' | paste -sd " " -)

    if [ "$sortedString" == "$SKIP" ]; then
        return 1
    else
        return 0
    fi
}

clear

user=$(whoami)
source $config_file_path
read -r -a disabled_users <<< "$DISABLED_USERS"
if [[ " ${disabled_users[*]} " =~ " ${user} " ]]; then
    echo ""
else
    if is_left; then
        show_next $NEXT_TIP
    else
        echo "No tips left. linuxtips -e to edit skipped tips."
    fi

    option=""

    while [ "$option" != "q" ]
    do
        if is_left; then
            echo ""
        else
            echo "No tips left. linuxtips -e to edit skipped tips."
        fi

        read -p 'n: next; p: previous; s: skip forever; q: quit: ' option
        case $option in
            n)
                show_next $NEXT_TIP;;
            p)
                if [ "$NEXT_TIP" -eq 1 ]; then
                    show_previous $(($TOTAL_TIPS - 1))
                elif [ "$NEXT_TIP" -eq 2 ]; then
                    show_previous $TOTAL_TIPS
                elif [ "$NEXT_TIP" -gt 2 ] && [ "$NEXT_TIP" -le $TOTAL_TIPS ]; then
                    show_previous $(($NEXT_TIP - 1))
                fi;;
            s)
                if [ "$NEXT_TIP" -eq 1 ]; then
                    sed -i "/^SKIP=/ s/\"\([^']*\)\"/\"\1 10\"/" $config_file_path
                else
                    sed -i "/^SKIP=/ s/\"\([^']*\)\"/\"\1 $(($NEXT_TIP - 1))\"/" $config_file_path
                fi
                source $config_file_path
                read -r -a skipArray <<< "$SKIP"
                sortedArray=($(echo "${skipArray[*]}" | tr ' ' '\n' | sort -n))
                sortedString=$(echo "${sortedArray[*]}" | tr ' ' '\n' | paste -sd " " -)
                sed -i "/^SKIP=/ s/\"\([^']*\)\"/\"${sortedString}\"/" $config_file_path
                if is_left; then
                    show_next $NEXT_TIP
                else
                    clear
                    echo "No tips left. linuxtips -e to edit skipped tips."
                fi;;
            q)
                echo "";;
            *)
                echo  "unknown"
                ;;
        esac
    done
fi
