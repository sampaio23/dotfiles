#!/bin/sh

locktext='Type password to unlock...'
insidecolor=00000000
ringcolor=ffffffff
keyhlcolor=d23c3dff
bshlcolor=d23c3dff
separatorcolor=00000000
insidevercolor=00000000
insidewrongcolor=d23c3dff
ringvercolor=ffffffff
ringwrongcolor=ffffffff
verifcolor=ffffffff
timecolor=ffffffff
datecolor=ffffffff
loginbox=00000066
font="sans-serif"

#scrot /tmp/screen.png

# the lock screen is 1366x768 and rectangle is at x=16 and y=7, with size 313x127

mpc pause

i3lock -t -i $(ls $HOME/.backgrounds | sort -R | tail -1) \
	--timepos='x+110:h-70' \
	--datepos='x+43:h-45' \
	--clock --date-align 1 --datestr "$locktext" \
	--insidecolor=$insidecolor --ringcolor=$ringcolor --line-uses-inside \
	--keyhlcolor=$keyhlcolor --bshlcolor=$bshlcolor --separatorcolor=$separatorcolor \
	--insidevercolor=$insidevercolor --insidewrongcolor=$insidewrongcolor \
	--ringvercolor=$ringvercolor --ringwrongcolor=$ringwrongcolor --indpos='x+280:h-70' \
	--radius=20 --ring-width=4 --veriftext='' --wrongtext='' \
	--verifcolor="$verifcolor" --timecolor="$timecolor" --datecolor="$datecolor" \
	--time-font="$font" --date-font="$font" --layout-font="$font" --verif-font="$font" --wrong-font="$font" \
	--noinputtext='' --force-clock --pass-media-keys $lockargs

while [[ $(pgrep -x i3lock) ]]; do
	[[ 10000 -lt $(xssstate -i) ]] && xset dpms force off
	sleep 5
done
