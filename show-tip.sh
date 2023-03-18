#!/bin/bash

clear

config_file_path="$HOME/tip-of-the-day/config.sh"

source $config_file_path

cat $TIPS_PATH/$CONNECTION_TIMES.txt

if [ "$CONNECTION_TIMES" -lt 10 ]; then
    t=$(($CONNECTION_TIMES + 1))
    sed -i "s/CONNECTION_TIMES=.*/CONNECTION_TIMES=$t/" $config_file_path
else
    sed -i "s/CONNECTION_TIMES=.*/CONNECTION_TIMES=$t/" $config_file_path
fi