#!/bin/bash

set -o pipefail

if ! bluetoothctl show | grep -q 'Powered: yes' ; then
   echo '%{F#707070}'
elif dev=$( bluetoothctl info | grep 'Alias:' ) ; then
   echo "%{F#536878} %{F#f0f0f0}${dev/*Alias: /}"
else
   echo '%{F#b0b0b0}'
fi
