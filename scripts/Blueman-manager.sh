#!/bin/bash

if [[ ! -z $(pgrep blueman-manager) ]]; then pkill -9 blueman-manager; else blueman-manager; fi
