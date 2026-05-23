#!/bin/bash

M3_MAC="E7:A3:2D:2C:C9:D1"

check_m3() {
    local info
    info=$(bluetoothctl info "$M3_MAC" 2>/dev/null)
    local battery_percent="--" # Default if no battery info found

    if echo "$info" | grep -q "Connected: yes"; then
        local battery_line
        battery_line=$(echo "$info" | grep -i "Battery Percentage")
        battery_percent="N/A" # Assume Not Available initially if line found

        if [[ -n "$battery_line" ]]; then
            local bat_val_hex
            bat_val_hex=$(echo "$battery_line" | sed -n -r 's/.*Battery Percentage: 0x([0-9A-Fa-f]+).*/\1/p')
            if [[ -n "$bat_val_hex" ]]; then
                battery_percent=$((16#$bat_val_hex)) #
            fi
        fi

#        echo $battery_percent

        if [[ "$battery_percent" -lt 20 ]]; then
          notify-send --urgency=WARNING "Mousce battery Low" "Level: ${batery_percent}%"
        fi
        if [[ "$battery_percent" -lt 10 ]]; then
          notify-send --urgency=CRITICAL "Mousce battery Low" "Level: ${batery_percent}%"
        fi            
    fi
}


while true; do
  check_m3
  sleep 600
done
