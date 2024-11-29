#!/usr/bin/env bash

polybar-msg cmd quit

while
   (( ++timeout < 10 )) &&
   pgrep --exact polybar >/dev/null
do
   echo $timeout
   sleep 1
done

if (( timeout == 10 )) ; then
   exit 11
fi

shopt -o nullglob
declare -a inputs=(
   /sys/devices/platform/coretemp.0/hwmon/hwmon*/temp1_input
)

HWMON_PATH="${inputs[0]}" polybar main & disown
