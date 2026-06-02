#!/usr/bin/env bash

# Copy the sddm theme into the system theme directory
set -euo pipefail

THEME_NAME="gruvbox-material"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="/usr/share/sddm/themes/${THEME_NAME}"

echo "Installing ${THEME_NAME} -> ${DEST}"
sudo rm -rf "${DEST}"
sudo mkdir -p "${DEST}"

sudo cp -r "${SRC}/." "${DEST}/"
sudo rm -f "${DEST}/install.sh"

# Activate via drop-in
sudo install -d /etc/sddm.conf.d
printf '[Theme]\nCurrent=%s\n' "${THEME_NAME}" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null

echo "Done. Preview with:"
echo "  sddm-greeter-qt6 --test-mode --theme ${DEST}"

