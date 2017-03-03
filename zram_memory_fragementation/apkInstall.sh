#!/bin/bash

deviceid=$1

adb -s ${deviceid} install ClashOfClans.apk
adb -s ${deviceid} install DaZhongDianPing.apk
adb -s ${deviceid} install JinRiNews.apk
adb -s ${deviceid} install KaiXinXiaoXiaoLe.apk
adb -s ${deviceid} install PlatVsZombi.apk
adb -s ${deviceid} install qq.apk
adb -s ${deviceid} install RoomEscape.apk
adb -s ${deviceid} install TengXunNews.apk
adb -s ${deviceid} install TengXunShiPin.apk
adb -s ${deviceid} install weixin.apk
adb -s ${deviceid} install YouKu.apk

