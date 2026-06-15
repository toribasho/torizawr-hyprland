#!/bin/bash

#!/bin/bash
sleep 1
# Forcefully clear any stalled or dead portal states
killall -9 xdg-desktop-portal-hyprland 2>/dev/null
killall -9 xdg-desktop-portal 2>/dev/null

# Launch the backends manually as background forks
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
