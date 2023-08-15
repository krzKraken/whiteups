#!/usr/bin/sh

echo "%{F#000000}  %{F#ffffff}$(/usr/sbin/ifconfig ens33 | grep "inet " | awk '{print $2}')%{-u} "
