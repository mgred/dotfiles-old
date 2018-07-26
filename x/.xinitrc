#!/bin/sh

if [ `xrandr | grep -c ' connected '` -eq 2 ]; then # dual-monitor
  monitors="$(xrandr | grep ' connected ' | awk '{print $1}')"
  set -- $monitors
  xrandr --output "$1" --auto --primary --output "$2"  --auto \
  --left-of "$1"  --rotate left
  #xrandr --output LVDS-1 --auto --primary --output DP-3 --auto \
  #--left-of LVDS-1 --rotate left
fi

exec dwm

#if [ `xrandr | grep VGA-1 | grep -c ' connected '` -eq 1 ]; then
#xrandr --output LVDS-1 --auto --primary --output VGA-1 --auto --right-of LVDS-1
#fi
#if [ `xrandr | grep DVI-1 | grep -c ' connected '` -eq 1 ]; then
#xrandr --output LVDS-1 --auto --primary --output DVI-1 --auto --right-of LVDS-1
#fi
#feh --bg-tile ~/Wallpapers/tile8.jpg    
##    xsetroot -solid \#cccccc
#else
#xrandr --output LVDS-1 --auto --primary --output VGA-1 --off --output DVI-1 --off
#feh --bg-center ~/Wallpapers/paperart5.jpg
#fi

#if [[ "$(xrandr | grep "$extern disconnected")" != "" ]]; then
#    xrandr --output "$extern" --off --output "$intern" --auto --primary
#else
#fi

# vim:tw=80:ts=2:sw=2:expandtab
