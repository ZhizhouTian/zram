#!/bin/bash
logname=$1.log
touch $logname

while true ; do
    adb root

    if [ $? -ne 0 ] ; then
    	sleep 1
    	continue
    fi

    break
done
	
echo "####################################" >> $logname
adb shell "cat /proc/vmstat" >> $logname
adb shell "cat /proc/meminfo" >> $logname
adb shell "cat /proc/buddyinfo" >> $logname

adb shell "echo 1 > /proc/sys/vm/compact_memory"

sleep 10

adb shell "cat /proc/vmstat" >> $logname
adb shell "cat /proc/meminfo" >> $logname
adb shell "cat /proc/buddyinfo" >> $logname

