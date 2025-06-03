#!/bin/bash

# User Configuration
# !!! REPLACE XX:XX:XX:XX:XX:XX WITH YOUR HEADPHONE'S MAC ADDRESS !!!
# Find your headphone's MAC address by running: bluetoothctl devices
HEADPHONE_MAC="64:68:76:5F:72:B2"

# --- Script Logic ---

# Function to get and format headphone status for Waybar
output_status_for_waybar() {
    local info
    # Try to get info, suppress stderr initially if device is not yet known by bluetoothctl
    info=$(bluetoothctl info "$HEADPHONE_MAC" 2>/dev/null)
    local connected=false
    local battery_percent="--" # Default if no battery info found
    local text
    local tooltip
    local class
    local alt_action # For the next click, though not directly used by this on-click method

    if echo "$info" | grep -q "Connected: yes"; then
        connected=true
        # --- BATTERY PARSING SECTION ---
        # This section attempts to get the battery percentage.
        # You MIGHT need to adjust this based on your device's output.
        # To debug:
        # 1. Connect your headphones.
        # 2. Run `bluetoothctl info YOUR_MAC_ADDRESS` in a terminal.
        # 3. Observe the line containing "Battery Percentage".
        # 4. Adjust the `sed` commands below if needed.
        local battery_line
        battery_line=$(echo "$info" | grep -i "Battery Percentage")
        battery_percent="N/A" # Assume Not Available initially if line found

        if [[ -n "$battery_line" ]]; then
            # Try to extract from "Battery Percentage: XX%" (e.g., "Battery Percentage: 75%")
            local bat_val_hex
            bat_val_hex=$(echo "$battery_line" | sed -n -r 's/.*Battery Percentage: 0x([0-9A-Fa-f]+).*/\1/p')
            if [[ -n "$bat_val_hex" ]]; then
                battery_percent=$((16#$bat_val_hex)) #
            fi
        fi
        # --- END OF BATTERY PARSING SECTION ---

        class="connected"
        if [[ "$battery_percent" == "N/A" ]] || [[ "$battery_percent" == "--" ]]; then # If still N/A or parsing failed
            text=" Conn."
            tooltip="Headphones: ${HEADPHONE_MAC}\nStatus: Connected (Battery N/A)\nClick to disconnect"
        else
            if [[ "$battery_percent" -lt 40 ]]; then
                class="connected lowbat"
            fi
            if [[ "$battery_percent" -lt 20 ]]; then
                class="connected critical"
            fi            
            text=" "
            tooltip="Edifier W820NB+: $battery_percent%\nClick to disconnect"
        fi
        alt_action="disconnect" # Informative for JSON, not used by current on-click
    else
        text=" Disc."
        tooltip="Edifier W820NB+: Disconnected\nClick to connect"
        class="disconnected"
        alt_action="connect" # Informative for JSON
    fi

    # Output JSON for Waybar
    printf '{"text": "%s", "tooltip": "%s", "class": "%s", "alt": "%s"}\n' \
        "$text" "$tooltip" "$class" "$alt_action"
}

# Main actions based on argument
case "$1" in
    connect)
        bluetoothctl connect "$HEADPHONE_MAC" > /dev/null
        sleep 2 # Give time for connection to establish
        output_status_for_waybar
        ;;
    disconnect)
        bluetoothctl disconnect "$HEADPHONE_MAC" > /dev/null
        sleep 1 # Give time for disconnection
        output_status_for_waybar
        ;;
    toggle)
        # Check current state to decide action
        # Suppress error if device not found (e.g. bluetooth off)
        current_info=$(bluetoothctl info "$HEADPHONE_MAC" 2>/dev/null)
        if echo "$current_info" | grep -q "Connected: yes"; then
            bluetoothctl disconnect "$HEADPHONE_MAC" > /dev/null
            sleep 1
        else
            # Attempt to power on bluetooth adapter if it's off
            if ! bluetoothctl show | grep -q "Powered: yes"; then
                 bluetoothctl power on
                 sleep 1 # Give it a moment
            fi
            bluetoothctl connect "$HEADPHONE_MAC" > /dev/null
            sleep 2
        fi
        output_status_for_waybar
        ;;
    status|*) # Default action if no argument or 'status' is given
        output_status_for_waybar
        ;;
esac
