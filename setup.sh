#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

usage() {
    cat <<'EOF'
Usage: sh setup.sh

Link the Mokka Zsh and Starship configuration into the current user's home.
Existing files are backed up before replacement. No packages are installed and
the login shell is not changed.
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

printf '\nMokka shell configuration installed.\n'
printf 'To use Zsh as your login shell: chsh -s "$(command -v zsh)"\n'
