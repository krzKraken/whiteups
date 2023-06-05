#!/bin/bash
 
ip_address=$(/bin/cat /home/krzkraken/.config/bspwm/themes/kraken/polybar/bin/target | awk '{print $1}')
machine_name=$(/bin/cat /home/krzkraken/.config/bspwm/themes/kraken/polybar/bin/target| awk '{print $2}')
 
if [ $ip_address ] && [ $machine_name ]; then
    echo "%{F#e51d0b}  $machine_name%{F#ffffff}%{u-} - $ip_address"
else
    echo "%{F#e51d0b}  %{u-}%{F#ffffff} No target"
fi
