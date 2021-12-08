#!/bin/sh

waiting_sec=10
cycles_min=`expr "\$TIMEOUT_SEC_MIN" / $waiting_sec` || exit 2
cycles_max=`expr "\$TIMEOUT_SEC_MAX" / $waiting_sec` || exit 3
cycles_left=`awk -v min=$cycles_min -v max=$cycles_max 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'` || exit 4
while
    load=`cat /proc/loadavg` || exit 5
    too_big=`echo $load | awk "{ print (\\$1 > $LOAD_MAX) ; }"` || exit 6
    [ $cycles_left != 0 -a $too_big = 1 ]
do
    sleep 10 || exit 7
    cycles_left=`expr $cycles_left - 1` || exit 8
done

start_jitter_sec=`expr "\$START_JITTER_SEC" / 1` || exit 9
jitter_sec=`awk "BEGIN{srand(); print int(rand()*($start_jitter_sec+1))}"` || exit 10
sleep $jitter_sec || exit 11
