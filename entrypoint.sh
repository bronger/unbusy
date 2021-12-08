#!/bin/sh

cycles_left=`awk -v min=50 -v max=70 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'` || exit 4
while
    load=`cat /proc/loadavg` || exit 5
    too_big=`echo $load | awk '{ print ($1 > 2) ; }'` || exit 6
    [ $cycles_left != 0 -a $too_big = 1 ]
do
    sleep 10 || exit 7
    cycles_left=`expr $cycles_left - 1` || exit 8
done
