TIPS_PATH=/var/tips

NEXT_TIP=4

TOTAL_TIPS=$(ls $TIPS_PATH | sed 's/\.txt//g' | sort -nr | cut -d $'\n' -f 1 )

SKIP=""

DISABLED_USERS=""