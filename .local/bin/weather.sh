#!/bin/sh

curl -s "wttr.in/$location" > "$HOME/.local/share/weatherreport" || exit 1 ;


rain=$(sed '16q;d' "$HOME/.local/share/weatherreport" | grep -wo "[0-9]*%" | sort -n | sed -e '$!d' | sed -e "s/^/ /g" | tr -d '%\n')

lowest=$(sed '13q;d' "$HOME/.local/share/weatherreport" | sed 's/\x1b\[[0-9;]*m//g' | grep -o "[0-9][0-9]" | sort -n | head -n 1 | sed -e "s/^/ /g" | tr -d '\n' | sed -e '$ s/$/°C/')

highest=$(sed '13q;d' "$HOME/.local/share/weatherreport" | sed 's/\x1b\[[0-9;]*m//g' | grep -o "[0-9][0-9]" | sort -n | tail -n 1 | sed -e "s/^/ /g" | tr -d '\n' | sed -e "$ s/$/°C/")

printf "$rain%% $lowest $highest"
