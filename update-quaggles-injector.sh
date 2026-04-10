#!/bin/bash
set -euo pipefail

STAGING_DIR="/home/iskela45/mnt/Juliett/Sims/Limo-staging"
TMP_DIR="/home/iskela45/mnt/Juliett/Sims/Scripts/tmp"
JSON_FILE="$STAGING_DIR/lmm_mods.json"
MOD_ID=1
REPO="Quaggles/dcs-input-command-injector"

# Fetch latest release info
echo "Checking latest release..."
RELEASE=$(curl -sf "https://api.github.com/repos/$REPO/releases/latest")
LATEST_VERSION=$(echo "$RELEASE" | jq -r '.tag_name')
DOWNLOAD_URL=$(echo "$RELEASE" | jq -r '.assets[] | select(.name == "DCS-Input-Command-Injector-Quaggles.zip") | .browser_download_url')

CURRENT_VERSION=$(jq -r --argjson id "$MOD_ID" '.installed_mods[] | select(.id == $id) | .version' "$JSON_FILE")

echo "Current: $CURRENT_VERSION  Latest: $LATEST_VERSION"

if [[ "$CURRENT_VERSION" == "$LATEST_VERSION" ]]; then
    echo "Already up to date."
    exit 0
fi

# Download
ZIP_FILE="$TMP_DIR/DCS-Input-Command-Injector-Quaggles-${LATEST_VERSION}.zip"
echo "Downloading $LATEST_VERSION..."
curl -fL "$DOWNLOAD_URL" -o "$ZIP_FILE"

# Extract to tmp, then copy contents into staging (strips the leading directory)
EXTRACT_DIR="$TMP_DIR/quaggles-extract"
rm -rf "$EXTRACT_DIR"
unzip -q "$ZIP_FILE" -d "$EXTRACT_DIR"

cp -r "$EXTRACT_DIR/DCS-Input-Command-Injector-Quaggles/Scripts" "$STAGING_DIR/1/"

# Update lmm_mods.json
NOW=$(date +%s)
TMP_JSON=$(mktemp)
jq --argjson id "$MOD_ID" --arg ver "$LATEST_VERSION" --argjson now "$NOW" \
    '(.installed_mods[] | select(.id == $id)) |= . + {
        version: $ver,
        install_time: $now,
        remote_update_time: $now,
        suppress_update_time: $now
    }' "$JSON_FILE" > "$TMP_JSON"
mv "$TMP_JSON" "$JSON_FILE"

echo "Updated to $LATEST_VERSION."

# Cleanup
rm -rf "$EXTRACT_DIR" "$ZIP_FILE"
