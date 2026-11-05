#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"

usage() {
    cat <<'EOF'
Usage: sh setup.sh

Link the Mokka Zsh and Starship configuration, install the Nusa Obsidian KDE
color scheme, and install the Nusa Plasma Style for the current user.
Existing shell and color-scheme files are backed up first. No packages are
installed, system files are changed, or login shell is changed.
EOF
}

backup_and_link() {
    source_path=$1
    target_path=$2

    if [ ! -f "$source_path" ]; then
        printf 'Missing source file: %s\n' "$source_path" >&2
        exit 1
    fi

    mkdir -p "$(dirname "$target_path")"

    if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
        printf 'Already linked: %s\n' "$target_path"
        return
    fi

    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        backup_path="$target_path.bak.$(date +%Y%m%d%H%M%S)"
        mv "$target_path" "$backup_path"
        printf 'Backed up: %s\n' "$backup_path"
    fi

    ln -s "$source_path" "$target_path"
    printf 'Linked: %s -> %s\n' "$target_path" "$source_path"
}

install_plasma_style() {
    default_theme=""
    for candidate in /usr/local/share/plasma/desktoptheme/default /usr/share/plasma/desktoptheme/default; do
        if [ -d "$candidate" ]; then
            default_theme=$candidate
            break
        fi
    done

    if [ -z "$default_theme" ]; then
        printf 'Plasma default theme not found; skipping Nusa Plasma Style.\n'
        printf 'Install KDE Plasma first, then rerun setup.sh.\n'
        return
    fi

    theme_dir="$DATA_DIR/plasma/desktoptheme/NusaObsidian"
    mkdir -p "$theme_dir/widgets" "$theme_dir/solid/widgets"

    # Keep Breeze's complete set of standard Plasma assets and override the
    # Nusa metadata plus both translucent and opaque panel backgrounds.
    cp -R "$default_theme/." "$theme_dir/"
    cp "$ROOT/config/plasma/desktoptheme/NusaObsidian/metadata.json" "$theme_dir/metadata.json"
    cp "$ROOT/config/plasma/desktoptheme/NusaObsidian/widgets/panel-background.svg" "$theme_dir/widgets/panel-background.svg"
    cp "$ROOT/config/plasma/desktoptheme/NusaObsidian/widgets/panel-background.svg" "$theme_dir/solid/widgets/panel-background.svg"

    printf 'Installed Nusa Obsidian Plasma Style: %s\n' "$theme_dir"
}

case "${1:-}" in
    "")
        ;;
    -h|--help)
        usage
        exit 0
        ;;
    *)
        usage >&2
        exit 2
        ;;
esac

if [ "$(id -u)" -eq 0 ]; then
    printf 'Run this script as your regular desktop user, not root.\n' >&2
    exit 1
fi

backup_and_link "$ROOT/config/zsh/.zshrc" "$HOME/.zshrc"
backup_and_link "$ROOT/config/starship/starship.toml" "$CONFIG_DIR/starship.toml"
backup_and_link "$ROOT/config/kde/NusaObsidian.colors" "$DATA_DIR/color-schemes/NusaObsidian.colors"
install_plasma_style

printf '\nNusa shell and KDE configuration installed.\n'
printf 'Select Nusa Obsidian in System Settings > Colors & Themes > Colors and Plasma Style.\n'
printf 'Copy the KvBrown SVG to ~/.config/Kvantum/NusaObsidian/NusaObsidian.svg, then select NusaObsidian in Kvantum Manager.\n'
printf 'To use Zsh as your login shell: chsh -s "$(command -v zsh)"\n'
