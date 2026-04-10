#!/bin/bash
# dcs.sh
# Launches DCS World via Lutris

LOG="/tmp/dcs.log"

echo "$(date) Launching DCS World..." | tee -a "$LOG"

lutris lutris:rungameid/dcs-world >> "$LOG" 2>&1 &

echo "DCS launch command sent." | tee -a "$LOG"
