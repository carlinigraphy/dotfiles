#!/bin/bash

read -r ACTIVE < <(
   systemctl show -P ActiveState wg-quick@wg0
)

case "$1" in
   toggle)
      if [[ $ACTIVE == 'active' ]] ; then
         sudo systemctl stop  wg-quick@wg0.service
      else
         sudo systemctl start wg-quick@wg0.service
      fi
      ;;

   *) if [[ $ACTIVE == 'active' ]] ; then
         echo "%{F#707070}WG:%{F#f0f0f0}wg0"
      else
         echo "%{F#707070}WG"
      fi
      ;;
esac
