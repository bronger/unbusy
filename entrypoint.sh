#!/bin/sh

printf %s "$LOAD_MAX" | grep -q "^[0-9]\+\(\\.[0-9]\+\)\?$" || exit 12
printf %s "$START_JITTER_SEC" | grep -q "^[0-9]\+$" || exit 13

if [ ! -z "$UPTIME_SEC_MAX" ]
then
    printf %s "$UPTIME_SEC_MAX" | grep -q "^[0-9]\+$" || exit 14
    too_old=`awk "{print (\\$1 > $UPTIME_SEC_MAX)}" /proc/uptime` || exit 15
    if [ $too_old = 1 ]
    then
        exit 0
    fi
fi

waiting_sec=10
cycles_min=`expr "\$TIMEOUT_SEC_MIN" / $waiting_sec` || exit 2
cycles_max=`expr "\$TIMEOUT_SEC_MAX" / $waiting_sec` || exit 3
cycles_left=`awk -v min=$cycles_min -v max=$cycles_max 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'` || exit 4
while
    too_big=`awk "{print (\\$1 > $LOAD_MAX)}" /proc/loadavg` || exit 6
    [ $cycles_left != 0 -a $too_big = 1 ]
do
    sleep 10 || exit 7
    cycles_left=`expr $cycles_left - 1` || exit 8
done

jitter_sec=`awk "BEGIN{srand(); print int(rand()*($START_JITTER_SEC+1))}"` || exit 10
sleep $jitter_sec || exit 11
