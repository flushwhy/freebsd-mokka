#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
BREEZE_DIR="/usr/local/share/sddm/themes/breeze"
THEME_ROOT="/usr/local/share/sddm/themes"
THEME_DIR="$THEME_ROOT/NusaObsidian"
SOURCE_DIR="$ROOT/config/sddm/NusaObsidian"

if [ "$(id -u)" -ne 0 ]; then
    printf 'Run this installer with sudo: sudo sh install-sddm.sh\n' >&2
    exit 1
fi

if [ ! -f "$BREEZE_DIR/Main.qml" ] || [ ! -f "$BREEZE_DIR/theme.conf" ]; then
    printf 'The installed Qt 6 Breeze SDDM theme was not found at %s\n' "$BREEZE_DIR" >&2
    exit 1
fi

if [ ! -f "$SOURCE_DIR/theme.conf" ] || [ ! -f "$SOURCE_DIR/metadata.desktop" ] || [ ! -f "$SOURCE_DIR/nusa-logo.svg" ] || [ ! -f "$SOURCE_DIR/nusa-background.svg" ] || [ ! -f "$SOURCE_DIR/Main.qml" ]; then
    printf 'Nusa SDDM theme source is incomplete: %s\n' "$SOURCE_DIR" >&2
    exit 1
fi

mkdir -p "$THEME_ROOT"

if [ -e "$THEME_DIR" ]; then
    BACKUP="$THEME_DIR.backup.$(date +%Y%m%d%H%M%S)"
    mv "$THEME_DIR" "$BACKUP"
    printf 'Previous Nusa theme backed up to %s\n' "$BACKUP"
fi

mkdir "$THEME_DIR"
cp -R "$BREEZE_DIR/." "$THEME_DIR/"
cp "$SOURCE_DIR/theme.conf" "$THEME_DIR/theme.conf"
cp "$SOURCE_DIR/metadata.desktop" "$THEME_DIR/metadata.desktop"
cp "$SOURCE_DIR/nusa-logo.svg" "$THEME_DIR/nusa-logo.svg"
cp "$SOURCE_DIR/nusa-background.svg" "$THEME_DIR/nusa-background.svg"
cp "$SOURCE_DIR/Main.qml" "$THEME_DIR/Main.qml"

printf '\nInstalled Nusa Obsidian SDDM theme.\n'
printf 'Open System Settings > Colors & Themes > Login Screen (SDDM), select Nusa Obsidian, then Apply.\n'
printf 'Breeze remains installed as a fallback.\n'
