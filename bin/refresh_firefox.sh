WID=`xdotool search --name "Mozilla Firefox" | head -1`
xdotool key --clearmodifiers --window $WID F5
