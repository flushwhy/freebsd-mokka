#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
RC_CONF=/etc/rc.conf
RC_CONF_DIR=/etc/rc.conf.d

usage() {
    cat <<'EOF'
Usage: sudo sh install-system.sh [--vmware]

Install Nusa's small system configuration profile. The default profile sets
this machine's hostname to "nusa". Pass --vmware on VMware guests to enable
the VMware Tools daemon at boot.

Existing configuration files are backed up before replacement. Known invalid
keys left by earlier manual setup are removed from /etc/rc.conf.
EOF
}

vmware=NO
case "${1:-}" in
    "") ;;
    --vmware) vmware=YES ;;
    -h|--help) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
esac

if [ "$(uname -s)" != FreeBSD ]; then
    printf 'This installer is intended for FreeBSD.\n' >&2
    exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
    printf 'Run this installer with sudo: sudo sh install-system.sh [--vmware]\n' >&2
    exit 1
fi

if ! command -v sysrc >/dev/null 2>&1; then
    printf 'sysrc is required but was not found.\n' >&2
    exit 1
fi

install_config() {
    source_path=$1
    target_path=$2

    if [ ! -f "$source_path" ]; then
        printf 'Missing configuration source: %s\n' "$source_path" >&2
        exit 1
    fi

    if [ -f "$target_path" ] && cmp -s "$source_path" "$target_path"; then
        printf 'Already current: %s\n' "$target_path"
        return
    fi

    mkdir -p "$(dirname "$target_path")"
    if [ -e "$target_path" ]; then
        backup_path="$target_path.bak.$(date +%Y%m%d%H%M%S)"
        cp -p "$target_path" "$backup_path"
        printf 'Backed up: %s\n' "$backup_path"
    fi

    install -o root -g wheel -m 0644 "$source_path" "$target_path"
    printf 'Installed: %s\n' "$target_path"
}

# Back up rc.conf once before removing the two known misspelled/obsolete keys.
if grep -Eq '^[[:space:]]*(iffconfig_em0|vmware_guest_enable)=' "$RC_CONF"; then
    backup_path="$RC_CONF.nusa-backup.$(date +%Y%m%d%H%M%S)"
    cp -p "$RC_CONF" "$backup_path"
    printf 'Backed up: %s\n' "$backup_path"
fi

if grep -Eq '^[[:space:]]*iffconfig_em0=' "$RC_CONF"; then
    sysrc -x iffconfig_em0
    printf 'Removed invalid rc.conf key: iffconfig_em0\n'
fi

if grep -Eq '^[[:space:]]*vmware_guest_enable=' "$RC_CONF"; then
    sysrc -x vmware_guest_enable
    printf 'Removed obsolete rc.conf key: vmware_guest_enable\n'
fi

install_config "$ROOT/config/system/rc.conf.d/hostname" "$RC_CONF_DIR/hostname"

if [ "$vmware" = YES ]; then
    install_config "$ROOT/config/system/rc.conf.d/vmware_guestd" "$RC_CONF_DIR/vmware_guestd"
fi

hostname_value=$(sysrc -f "$RC_CONF_DIR/hostname" -n hostname)
if [ -n "$hostname_value" ]; then
    hostname "$hostname_value"
    printf 'Active hostname: %s\n' "$hostname_value"
fi

printf '\nNusa system configuration is installed.\n'
if [ "$vmware" = YES ]; then
    printf 'VMware guest integration is enabled for the next boot.\n'
fi
