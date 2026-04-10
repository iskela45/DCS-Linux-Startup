#!/bin/bash
# telemffb.sh
# Starts TelemFFB

LOG="/tmp/telemffb.log"

pkill -f "main.py" 2>/dev/null
sleep 1

echo "$(date) Starting TelemFFB..." | tee -a "$LOG"

bash /home/iskela45/Projects/sim/VPforce-TelemFFB/run.sh >> "$LOG" 2>&1 &

echo "TelemFFB started." | tee -a "$LOG"