#!/bin/bash

# Terminate already running bar instances
killall -q polybar

MONITOR=`polybar -m|tail -1|sed -e 's/:.*$//g'`

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
polybar main &

echo "Polybar launched on $MONITOR..."
