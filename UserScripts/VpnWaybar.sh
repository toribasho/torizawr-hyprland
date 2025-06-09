#!/bin/bash

# vpn_waybar.sh - Waybar module script for VPN status

# --- Configuration ---
# Icons (requires Nerd Fonts - https://www.nerdfonts.com/)
# If you don't have Nerd Fonts, you can remove these or replace them with text.
ICON_CONNECTED="󰕥"       # Example: nf-mdi-shield_check
ICON_DISCONNECTED="󰦜" # Example: nf-mdi-shield_off_outline
# ICON_CONNECTING="shield_sync_outline" # Example: nf-mdi-shield_sync_outline (For future enhancement)

# --- Logic ---
# Get active VPN connection name.
# We look for connections of type 'vpn' that are currently active.
ACTIVE_VPN_INFO=$(nmcli -t -f NAME,TYPE,STATE con show --active 2>/dev/null | grep ':vpn:')
ACTIVE_VPN_NAME=$(echo "$ACTIVE_VPN_INFO" | cut -d':' -f1)
# ACTIVE_VPN_STATE=$(echo "$ACTIVE_VPN_INFO" | cut -d':' -f3) # e.g., 'activated', 'activating'

if [ -n "$ACTIVE_VPN_NAME" ]; then
    # VPN is connected
    VPN_DEVICE=tun0
    VPN_IP="Acquiring..." # Default IP status

    if [ -n "$VPN_DEVICE" ] && [ "$VPN_DEVICE" != "--" ]; then
        # Try to get the IP address from the VPN device
        # ip -4 addr show dev <DEVICE> | grep -oP 'inet \K[\d.]+'
        CURRENT_IP=$(ip -4 addr show dev "$VPN_DEVICE" 2>/dev/null | grep -oP 'inet \K[\d.]+' | head -n1)
        if [ -n "$CURRENT_IP" ]; then
            VPN_IP="$CURRENT_IP"
        fi
    fi
    
    # Output JSON for Waybar
    # Tooltip shows more details on hover
    printf '{"text": "%s ", "tooltip": "%s Status: Connected Interface: %s IP: %s", "class": "connected"}' \
        "$ICON_CONNECTED" \
        # "$ACTIVE_VPN_NAME" \
        "$ACTIVE_VPN_NAME" \
        "${VPN_DEVICE:-N/A}" \
        "$VPN_IP"
else
    # VPN is disconnected
    printf '{"text": "%s ", "tooltip": "VPN: Disconnected", "class": "disconnected"}' \
        "$ICON_DISCONNECTED"
fi
