#!/bin/bash
# baraction.sh for spectrwm status bar
# From http://wiki.archlinux.org/index.php/Scrotwm

bat() {
	capacity=$(cat /sys/class/power_supply/BAT0/capacity)

	[ $capacity -le 100 ] && disc=" "
	[ $capacity -le 80 ] && disc=' '
	[ $capacity -le 60 ] && disc=' '
	[ $capacity -le 40 ] && disc=' '
	[ $capacity -le 20 ] && disc=' '

	status=$(sed "s/Discharging/$disc/;s/Not charging//;s/Charging//;s/Unknown/ /;s/Full/⚡/" /sys/class/power_supply/BAT0/status)

	echo -e "$status $capacity%"
}

temp() {
	echo -e $(cat /sys/class/thermal/thermal_zone0/temp | rev | cut -c4- | rev) "°C" 
}

wlan() {
	ssid=$(iwgetid| grep -o '"[^"]\+"' | sed 's/"//g')
[[ ! -z "$ssid" ]] && echo '|  ' $(iwgetid | grep -o '"[^"]\+"' | sed 's/"//g') '|'
[[ -z "$ssid" ]] && echo '|'
}

vol() {
volstat="$(pactl list sinks)"


vol="$(echo "$volstat" | grep '^[[:space:]]Volume:' | sed "s,.* \([0-9]\+\)%.*,\1,;1q")"

if [ "$vol" -gt "70" ]; then
	icon=""
elif [ "$vol" -lt "30" ]; then
	icon=""
else
	icon=""
fi

echo "$icon" "$vol"
}

song() {
	echo "$(mpc status | sed "/^volume:/d" | tac | sed -e "s/\\&/&amp;/g;s/\\[paused\\].*//g;s/\\[playing\\].*//g" | tr -d '\n') $(mpc status | sed '2q;d' | awk '{print $3}' | sed "s/\// \/ /")"
}

SLEEP_SEC=1
#loops forever outputting a line every SLEEP_SEC secs
while :; do
		echo "||   $(song) | +@fg=3; $(vol)% +@fg=0; $(wlan) +@fg=2;  $(temp) +@fg=0; | +@fg=4; $(bat) +@fg=0; ||"
	sleep $SLEEP_SEC
done
