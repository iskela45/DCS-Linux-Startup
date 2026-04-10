#!/bin/bash
# linuxtrack.sh
# Starts LinuxTrack

LOG="/tmp/linuxtrack.log"

if pgrep -fi "ltr_gui" > /dev/null; then
    echo "LinuxTrack already running, skipping." | tee -a "$LOG"
    exit 0
fi
sleep 1

echo "$(date) Starting LinuxTrack..." | tee -a "$LOG"

QT_QPA_PLATFORM=xcb \
LD_LIBRARY_PATH=/home/iskela45/mnt/Juliett/Sims/linuxtrack-git/linuxtrackx-ir/build/src \
/home/iskela45/mnt/Juliett/Sims/linuxtrack-git/linuxtrackx-ir/build/src/qt_gui/ltr_gui >> "$LOG" 2>&1 &

echo "LinuxTrack started." | tee -a "$LOG"