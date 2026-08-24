#!/bin/bash

if [[ ! -z $(pgrep nm-connection-e) ]]; then 
  pkill -9 nm-connection-e; 
else 
  nm-connection-editor; 
fi
