#!/usr/bin/env bash

declare -i timeout
declare -x HWMON_PATH

killall -q polybar

while
   (( --timeout > 0 )) &&
   pgrep --euid $UID --exact polybar >/dev/null
do
   sleep 1
done

declare -a inputs=(
   /sys/devices/platform/coretemp.0/hwmon/hwmon*/temp1_input
)

HWMON_PATH="${inputs[0]}" polybar main & disown
