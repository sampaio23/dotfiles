#! /bin/bash

xset r rate 250 60 &
feh --bg-scale $HOME/.backgrounds/$(ls /home/luiz-sampaio/.backgrounds | sort -R | tail -1 | tr -d '%\n') &
xrdb ~/.Xresources &
nm-applet --no-agent &

$HOME/.config/polybar/launch.sh &

#dunst &
#dwmblocks &
#exec monsterwm
#exec dwm
exec frankenwm
