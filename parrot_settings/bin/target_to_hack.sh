#!/bin/bash
 
ip_address=$(cat /home/krzkraken/.config/bin/target | awk '{print $1}')
machine_name=$(cat /home/krzkraken/.config/bin/target | awk '{print $2}')
 
if [ $ip_address ] && [ $machine_name ]; then
    echo "%{F#000000}什  %{F#ffffff}$machine_name %{u-}   $ip_address"
else
    echo "%{F#000000}什  %{u-}%{F#ffffff} No target"
fi
