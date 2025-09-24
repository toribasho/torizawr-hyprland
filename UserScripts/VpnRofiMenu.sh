#!/bin/bash

# vpn_rofi.sh - Rofi menu for VPN connections

# --- Configuration ---
# Waybar signal number to refresh the VPN module.
# This MUST match the "signal" number in your Waybar config for this module.
WAYBAR_SIGNAL=10 # Corresponds to RTMIN+10

# Rofi theming (optional, can be handled by your global Rofi config)
# Adjust width as needed, or remove if you have a theme.
ROFI_THEME_STR='window {width: 500px;} listview {lines: 4; columns: 1;} mainbox {children: [listview];}'

# Icons for Rofi menu (requires Nerd Fonts)
# If you don't have Nerd Fonts, you can remove these icon variables and their usage below.
ICON_DISCONNECT="󰦜"         # Example: nf-mdi-shield_off_outline
ICON_CONNECT="󰴴"            # Example: nf-mdi-shield_link_variant_outline

# --- Logic ---
# Get active VPN connection name
ACTIVE_VPN_NAME=$(nmcli -t -f NAME,TYPE con show --active 2>/dev/null | grep ':vpn$' | cut -d':' -f1)

ROFI_PROMPT="VPN Control"
declare -a MENU_OPTIONS

# Option to disconnect if a VPN is active
if [ -n "$ACTIVE_VPN_NAME" ]; then
    # MENU_OPTIONS+=("${ICON_DISCONNECT} Disconnect: ${ACTIVE_VPN_NAME}")
    (nmcli con down id "$ACTIVE_VPN_NAME") >/dev/null 2>&1 &

    sleep 2 # Brief pause to allow nmcli to initiate the action
    if pgrep -x "waybar" > /dev/null; then
        pkill -RTMIN+"$WAYBAR_SIGNAL" waybar
    fi
    exit 0 
fi

# Get all configured VPN connections (NAME field, where TYPE is vpn)
ALL_VPNS=$(nmcli -t -f NAME,TYPE connection show 2>/dev/null | grep ':vpn$' | cut -d':' -f1)

# Add options to connect to VPNs that are not currently active
while IFS= read -r vpn_name; do
    if [ "$vpn_name" != "$ACTIVE_VPN_NAME" ]; then
        MENU_OPTIONS+=("${ICON_CONNECT} Connect: ${vpn_name}")
    fi
done <<< "$ALL_VPNS"

# If no actions are available (no VPNs configured, or only active one listed for disconnect but nothing else)
if [ ${#MENU_OPTIONS[@]} -eq 0 ]; then
    if [ -z "$ALL_VPNS" ] && [ -z "$ACTIVE_VPN_NAME" ]; then
        rofi -e "No VPN connections configured." -theme-str "$ROFI_THEME_STR" -p "$ROFI_PROMPT"
    else
        # This case implies only an active VPN exists and is listed for disconnect,
        # but no other VPNs are configured to connect to.
        rofi -e "No other VPNs to connect to." -theme-str "$ROFI_THEME_STR" -p "$ROFI_PROMPT"
    fi
    exit 0
fi

# Show Rofi menu
# -dmenu: Run Rofi in dmenu mode (read from stdin, print selection to stdout)
# -p: Set prompt text
# -i: Case-insensitive search
# -l: Number of lines to display
# -markup-rows: Allow pango markup in options (if icons or formatting need it)
# -theme-str: Apply theme string directly
CHOSEN_OPTION=$(printf "%s\n" "${MENU_OPTIONS[@]}" | rofi -dmenu -p "$ROFI_PROMPT" -i -location 3 -l ${#MENU_OPTIONS[@]} -theme-str "$ROFI_THEME_STR" -markup-rows -dpi 100)

# Handle chosen option
if [ -n "$CHOSEN_OPTION" ]; then
    # Remove icon part (everything before the first space)
    CHOSEN_TEXT_PART=$(echo "$CHOSEN_OPTION" | sed 's/^[^ ]* //')
    
    # Extract action ("Connect" or "Disconnect") and VPN ID (the connection name)
    ACTION_PART=$(echo "$CHOSEN_TEXT_PART" | awk '{print $1}') # "Connect:" or "Disconnect:"
    ACTION=${ACTION_PART%:} # Remove trailing colon
    VPN_ID=$(echo "$CHOSEN_TEXT_PART" | sed -E "s/^${ACTION_PART} //") # Get the rest as VPN ID

    COMMAND_EXECUTED=0
    if [ "$ACTION" == "Connect" ]; then
        # notify-send "VPN Manager" "Attempting to connect to '$VPN_ID'..."
        # Execute nmcli in the background to prevent Rofi from hanging
        (nmcli con up id "$VPN_ID") >/dev/null 2>&1 &
        COMMAND_EXECUTED=1
    elif [ "$ACTION" == "Disconnect" ]; then
        # notify-send "VPN Manager" "Attempting to disconnect from '$VPN_ID'..."
        (nmcli con down id "$VPN_ID") >/dev/null 2>&1 &
        COMMAND_EXECUTED=1
    else
        notify-send -u critical "VPN Manager" "Error: Unknown action '$ACTION' for '$VPN_ID'."
    fi

    # If a command was attempted, give NetworkManager a moment and then refresh Waybar
    if [ "$COMMAND_EXECUTED" -eq 1 ]; then
        sleep 2 # Brief pause to allow nmcli to initiate the action
        if pgrep -x "waybar" > /dev/null; then
            pkill -RTMIN+"$WAYBAR_SIGNAL" waybar
        fi
    fi
fi

exit 0
