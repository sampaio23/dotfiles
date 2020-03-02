#!/bin/sh

# Feed this script a link and it will give dmenu
# some choice programs to use to open it.

clipcopy=$(xclip -o)

case "$(printf "Download Youtube Music\\nBrowser" | dmenu -i -p "Open link with:")" in
	"Download Youtube Music") tsp youtube-dl -f 'bestaudio[ext=m4a]' $clipcopy >/dev/null 2>&1 ;;
	"Browser") setsid firefox $clipcopy >/dev/null 2>&1 & ;;
esac
