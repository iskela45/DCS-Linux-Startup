#!/bin/bash
# simstart.sh
# Master script to start the sim setup.
#
# Usage:
#   ./simstart.sh           -- start VM, receiver, and DCS
#   ./simstart.sh -debug    -- same, with verbose output

SCRIPT_DIR="/home/iskela45/mnt/Juliett/Sims/DCS-Linux-Startup"
WINWING_DIR="/home/iskela45/mnt/Juliett/Sims/SimAppPro-on-Linux-input-transmitter"

if [ "$1" = "-debug" ]; then
    OUT=/dev/stdout
else
    OUT=/dev/null
fi

run() {
    bash "$1" > "$OUT" 2>&1
}

# turn off MFD if simstart.sh is forcibly killed
trap 'bash "$SCRIPT_DIR/mfd-display.sh" disable' EXIT

echo "=== Sim startup $(date) ==="

# Start VM and attach USB devices
run "$WINWING_DIR/winwing-start.sh"
if [ $? -ne 0 ]; then
    echo "VM startup failed, aborting."
    exit 1
fi

# Start virtual input receiver
run "$WINWING_DIR/winwing-receiver.sh"
if [ $? -ne 0 ]; then
    echo "Receiver startup failed, aborting."
    exit 1
fi

# Start LinuxTrack
run "$SCRIPT_DIR/linuxtrack.sh"
sleep 2
if ! pgrep -fi "ltr_gui" > /dev/null; then
    echo "LinuxTrack failed to start, aborting."
    exit 1
fi

# Start TelemFFB
run "$SCRIPT_DIR/telemffb.sh"
if [ $? -ne 0 ]; then
    echo "TelemFFB startup failed, aborting."
    exit 1
fi

# Update Quaggles Input Command Injector
echo "Checking Quaggles injector for updates..."
bash "$SCRIPT_DIR/update-quaggles-injector.sh" > "$OUT" 2>&1 || echo "Quaggles injector update failed, continuing."

# Enable MFD screen before launch
bash "$SCRIPT_DIR/mfd-display.sh" enable

# Launch DCS (and SRS) via launch-dcs.sh
echo "Launching DCS..."
bash "/home/iskela45/mnt/Juliett/Sims/DCS-on-Linux/tools/launch-dcs.sh" > "$OUT" 2>&1

# Disable MFD screen after DCS exits
bash "$SCRIPT_DIR/mfd-display.sh" disable

echo "=== Startup complete ==="
