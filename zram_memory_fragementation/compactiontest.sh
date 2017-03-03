#!/bin/bash
set -x

deviceid=$1

logname=logs.${deviceid}
mv $logname $logname.bak
touch $logname

apps=(
	'com.supercell.clashofclans.huawei/com.supercell.clashofclans.GameAppKunlun'
	'com.dianping.v1/com.dianping.main.guide.SplashScreenActivity'
	'com.ss.android.article.news/com.ss.android.article.news.activity.SplashActivity'
	'com.happyelements.AndroidAnimal/com.happyelements.hellolua.MainActivity'
	'com.popcap.pvz2cthdhwct/com.qihoo.util.StartActivity'
	'com.tencent.mobileqq/com.tencent.mobileqq.activity.SplashActivity'
	'air.com.martian.RoomEscape1.huawei/air.com.martian.RoomEscape1.huawei.AppEntry'
	'com.tencent.news/com.tencent.news.activity.SplashActivity'
	'com.tencent.qqlive/com.tencent.qqlive.ona.activity.WelcomeActivity'
	'com.tencent.mm/com.tencent.mm.ui.LauncherUI'
#	'com.youku.phone/com.youku.phone.ActivityWelcome'
)

while true ; do
	adb -s ${deviceid} root

	if [ $? -ne 0 ] ; then
		sleep 1
		continue
	fi

	uptime=$(adb -s ${deviceid} shell uptime|awk '{print $3}')
	echo $uptime
	
	#wait for 3 mins
	while true ; do
		uptime=$(adb -s ${deviceid} shell uptime|awk '{print $3}');
		echo "$uptime"
		if [ $uptime -gt 2 ]; then
			break
		fi
		sleep 1
	done

	for j in `seq 1 5`; do
		for appname in ${apps[@]}; do
			adb -s ${deviceid} shell am start ${appname}
			sleep 50
	
			adb -s ${deviceid} shell input keyevent 3
			sleep 10
		done
	done
	
	echo "####################################" >> $logname
	adb -s ${deviceid} shell "cat /proc/vmstat" >> $logname
	adb -s ${deviceid} shell "cat /proc/meminfo" >> $logname
	adb -s ${deviceid} shell "cat /proc/buddyinfo" >> $logname
	adb -s ${deviceid} shell "cat sys/kernel/debug/extfrag/unusable_index" >> $logname

	adb -s ${deviceid} shell "echo 1 > /proc/sys/vm/compact_memory"

	sleep 10

	adb -s ${deviceid} shell "cat /proc/vmstat" >> $logname
	adb -s ${deviceid} shell "cat /proc/meminfo" >> $logname
	adb -s ${deviceid} shell "cat /proc/buddyinfo" >> $logname
	adb -s ${deviceid} shell "cat sys/kernel/debug/extfrag/unusable_index" >> $logname

	adb -s ${deviceid} shell reboot
done
