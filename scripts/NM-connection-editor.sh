#!/bin/bash

if [[ ! -z $(pgrep nm-connection-editor) ]]; then 
  pkill -9 nm-connection-editor; 
else 
  nm-connection-editor; 
fi
