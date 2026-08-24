#!/bin/bash

if [[ ! -z $(pgrep -f "kitty --title=gazelle-tui") ]]; then 
  pkill -f -9 "kitty --title=gazelle-tui"; 
else 
  kitty --title=gazelle-tui gazelle; 
fi
