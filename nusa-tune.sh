#!/bin/sh
# Nusa Tune: read-only FreeBSD workstation diagnostics.
# No settings are changed by this script.

set -eu

usage() {
    cat <<'EOF'
Usage: sh nusa-tune.sh inspect

Collects read-only system information for evidence-based Nusa tuning.
This command does not modify sysctl values, loader settings, or rc.conf.
EOF
}

read_sysctl() {
    oid=$1
    value=$(sysctl -n "$oid" 2>/dev/null || true)
    if [ -n "$value" ]; then
        printf '%s\n' "$value"
    else
        printf '%s\n' "unavailable"
    fi
}

case "${1:-inspect}" in
    -h|--help|help)
        usage
        exit 0
        ;;
    inspect)
        ;;
    *)
        usage >&2
        exit 2
        ;;
esac

if [ "$(uname -s)" != "FreeBSD" ]; then
    printf 'Nusa Tune currently supports FreeBSD only.\n' >&2
    exit 1
fi

printf '%s\n' 'Nusa Tune — read-only system report'
printf '%s\n' '===================================='
printf 'Release:       %s\n' "$(freebsd-version -kru 2>/dev/null | tr '\n' ' ' || uname -r)"
printf 'Architecture:  %s\n' "$(uname -m)"
printf 'CPU model:     %s\n' "$(read_sysctl hw.model)"
printf 'CPU cores:     %s\n' "$(read_sysctl hw.ncpu)"
printf 'Memory bytes:  %s\n' "$(read_sysctl hw.physmem)"
printf 'VM guest:      %s\n' "$(read_sysctl kern.vm_guest)"
printf '\n%s\n' 'Scheduler'
printf 'Name:          %s\n' "$(read_sysctl kern.sched.name)"
printf 'ULE interact:  %s\n' "$(read_sysctl kern.sched.ule.interact)"
printf 'ULE preempt:   %s\n' "$(read_sysctl kern.sched.ule.preempt_thresh)"
printf '\n%s\n' 'CPU frequency / power'
printf 'Frequency driver: %s\n' "$(read_sysctl dev.cpufreq.0.freq_driver)"
printf 'Current CPU freq: %s\n' "$(read_sysctl dev.cpu.0.freq)"
printf 'HWP EPP:          %s\n' "$(read_sysctl dev.hwpstate_intel.0.epp)"
printf '\n%s\n' 'Network processing'
printf 'net.isr.maxthreads: %s\n' "$(read_sysctl net.isr.maxthreads)"
printf 'net.isr.bindthreads: %s\n' "$(read_sysctl net.isr.bindthreads)"
printf 'net.isr.dispatch: %s\n' "$(read_sysctl net.isr.dispatch)"
printf '\n%s\n' 'Memory / compatibility'
printf 'ZFS ARC max:        %s\n' "$(read_sysctl vfs.zfs.arc_max)"
printf 'ZFS ARC size:       %s\n' "$(read_sysctl kstat.zfs.misc.arcstats.size)"
printf 'SHM allow removed:  %s\n' "$(read_sysctl kern.ipc.shm_allow_removed)"
printf '\n%s\n' 'Report complete. No system settings were changed.'
