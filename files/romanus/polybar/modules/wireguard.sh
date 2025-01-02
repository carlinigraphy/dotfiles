#!/bin/bash

state=$(
   nmcli --fields GENERAL.STATE connection show wg0 | awk '{print $2}'
)

case "$1" in
   toggle)
      if [[ $state == 'activated' ]] ; then
         nmcli connection down wg0
      else
         nmcli connection up wg0
      fi
      ;;

   *) if [[ $state == 'activated' ]] ; then
         echo "%{F#707070}WG:%{F#f0f0f0}wg0"
      else
         echo "%{F#707070}WG"
      fi
      ;;
esac
