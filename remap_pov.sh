#!/bin/bash

# Remaps DCS POV hat inputs to button equivalents in all .diff.lua files
# Usage: ./remap_pov.sh <directory>

DIR="${1:-.}"

if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a directory"
    exit 1
fi

FILES=$(find "$DIR" -name "*.diff.lua")

if [ -z "$FILES" ]; then
    echo "No .diff.lua files found in '$DIR'"
    exit 1
fi

declare -A REPLACEMENTS=(
    ["JOY_BTN_POV1_L"]="JOY_BTN17"
    ["JOY_BTN_POV1_D"]="JOY_BTN18"
    ["JOY_BTN_POV1_R"]="JOY_BTN19"
    ["JOY_BTN_POV1_U"]="JOY_BTN20"

    ["JOY_BTN_POV2_L"]="JOY_BTN21"
    ["JOY_BTN_POV2_D"]="JOY_BTN22"
    ["JOY_BTN_POV2_R"]="JOY_BTN23"
    ["JOY_BTN_POV2_U"]="JOY_BTN24"

    ["JOY_BTN_POV3_L"]="JOY_BTN9"
    ["JOY_BTN_POV3_D"]="JOY_BTN10"
    ["JOY_BTN_POV3_R"]="JOY_BTN11"
    ["JOY_BTN_POV3_U"]="JOY_BTN12"

    ["JOY_BTN_POV4_L"]="JOY_BTN13"
    ["JOY_BTN_POV4_D"]="JOY_BTN14"
    ["JOY_BTN_POV4_R"]="JOY_BTN15"
    ["JOY_BTN_POV4_U"]="JOY_BTN16"
)

for FILE in $FILES; do
    ORIGINAL=$(cat "$FILE")
    MODIFIED="$ORIGINAL"

    for FROM in "${!REPLACEMENTS[@]}"; do
        TO="${REPLACEMENTS[$FROM]}"
        MODIFIED="${MODIFIED//$FROM/$TO}"
    done

    if [ "$ORIGINAL" != "$MODIFIED" ]; then
        echo "$MODIFIED" > "$FILE"
        echo "Updated: $FILE"
    else
        echo "No changes: $FILE"
    fi
done
