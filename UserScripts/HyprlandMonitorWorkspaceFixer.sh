#!/bin/bash

# 1. Dynamically find the signature if the env var is missing
if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    HYPRLAND_INSTANCE_SIGNATURE=$(hyprctl instances -j | jq -r '.[0].instance')
fi

# 2. Construct the absolute path
SOCKET_PATH="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# 3. Verify the socket exists before starting
if [ ! -S "$SOCKET_PATH" ]; then
    echo "Error: Socket not found at $SOCKET_PATH"
    exit 1
fi

handle_disconnect() {
    # Get the name of your laptop monitor (usually the one with ID 0)
    PRIMARY=$(hyprctl monitors -j | jq -r '.[] | select(.id == 0) | .name')
    
    # Move all workspaces to the primary monitor
    # We use -j to get a clean list of workspace IDs
    for i in $(hyprctl workspaces -j | jq -r '.[] | .id'); do
        hyprctl dispatch moveworkspacetomonitor "$i" "$PRIMARY"
    done
}

# 4. Listen to the socket
socat -U - "UNIX-CONNECT:$SOCKET_PATH" | while read -r line; do
    if [[ "$line" == "monitorremoved>>"* ]]; then
        # Small sleep ensures Hyprland has finished updating the internal monitor list
        sleep 0.5
        handle_disconnect
    fi
done
