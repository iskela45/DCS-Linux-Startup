#!/bin/bash
# mfd-display.sh
# Enable or disable the MFD screen (DP-4 / REG USB_Monitor).
#
# Usage:
#   ./mfd-display.sh enable
#   ./mfd-display.sh disable

MFD_OUTPUT="DVI-I-1"

case "$1" in
    enable)
        echo "Enabling MFD display ($MFD_OUTPUT)..."
        kscreen-doctor output.$MFD_OUTPUT.enable
        ;;
    disable)
        echo "Disabling MFD display ($MFD_OUTPUT)..."
        kscreen-doctor output.$MFD_OUTPUT.disable
        ;;
    *)
        echo "Usage: $0 {enable|disable}"
        exit 1
        ;;
esac
