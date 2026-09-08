#!/bin/bash

if [[ ! -z $(pgrep blueman-manager) ]]; then pkill -f "blueman-manager|blueman-applet"; else blueman-manager; fi
