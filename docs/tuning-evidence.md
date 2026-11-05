# Nusa Tune: tuning evidence

Nusa Tune is deliberately conservative. A setting does not become a default because it appears in a forum post or a copied `sysctl.conf`. It needs a current FreeBSD 15 reference, a clear hardware/workload match, and reproducible evidence that it improves the intended desktop workload without unacceptable regressions.

## Current decision

**No global kernel performance tunables are enabled.** FreeBSD already dynamically tunes many VM and scheduler behaviors. Nusa Tune starts with read-only inspection so recommendations can be based on the actual machine.

## Reviewed candidates

| Candidate | Evidence | Decision |
|---|---|---|
| `kern.sched.preempt_thresh=224` | Common in older desktop-tuning posts. FreeBSD 15 forum discussion documents the scheduler OID moving under `kern.sched.ule.preempt_thresh`; another recent discussion explains ULE's interactive scoring and advises against changing it without a workload-specific reason. | **Exclude from defaults.** Old values and old OID names are not a proven universal desktop improvement. |
| `kern.sched.ule.interact` | ULE already detects interactive tasks. Recent FreeBSD forum discussion describes its default as 30 and cautions that changing it can disable the intended scoring behavior at extremes. | **Leave at default.** |
| `powerd` / `powerdxx` | FreeBSD Handbook documents CPU frequency control, but notes Intel Speed Shift's `hwpstate_intel` driver supersedes the old powerd behavior on supported systems. | **Hardware-specific only.** Never enable blindly; skip VMware guests and systems using the HWP driver unless a specific supported use case is demonstrated. |
| Intel LinuxKPI graphics tunables | FreeBSD Handbook documents these for Intel graphics using `drm-kmod`. | **Driver-specific only.** Not applicable to VMware's virtual display adapter. |
| `net.isr.*` multicore settings | A 2026 forum user reports a positive desktop network experience, but the thread does not establish a general, controlled performance result. | **Do not enable by default.** Consider only for a measured network-processing bottleneck. |
| ZFS ARC limits | Forum discussion includes anecdotal values and later reports that the original perceived slowdown had another cause. | **Do not tune by default.** Use only when measured memory pressure or workload-specific evidence supports it. |
| `kern.ipc.shm_allow_removed` | Appears in older desktop posts as a Chromium compatibility setting. | **Compatibility-only.** Apply only if a specific application requires it, not as a speed tweak. |

## Sources

- [FreeBSD Handbook: Configuration, Services, Logging and Power Management](https://docs.freebsd.org/en/books/handbook/config/) — sysctl behavior, CPU frequency control, Intel Speed Shift, and Intel graphics power settings.
- [FreeBSD Architecture Handbook: Virtual Memory](https://docs.freebsd.org/en/books/arch-handbook/vm/) — explains that FreeBSD dynamically tunes VM behavior and discourages unnecessary manual VM tuning.
- [FreeBSD tuning(7)](https://man.freebsd.org/cgi/man.cgi?query=tuning) — official performance-tuning guidance.
- [FreeBSD Forums: kern.sched.preemp_tresh (July 2026)](https://forums.freebsd.org/threads/kern-sched-preemp_tresh.103259/) — FreeBSD 15 scheduler OID changes and ULE interactive scheduling discussion.
- [FreeBSD Forums: Tuning for Desktop Use](https://forums.freebsd.org/threads/tuning-for-desktop-use.73849/) — community examples; settings are not treated as universal defaults.
- [FreeBSD Forums: multicore net.isr](https://forums.freebsd.org/threads/beautiful-desktop-net-performance-with-multicore-net-isr.102356/) — promising report, not sufficient by itself for a default.
- [FreeBSD Forums: VMware and KDE](https://forums.freebsd.org/threads/trying-to-run-kde-6-plasma-with-wayland.93951/page-36) — current discussion of VMware's virtual graphics limitations on FreeBSD.

## Rules for adding a tweak

1. Confirm the setting exists on the target FreeBSD release and identify its default.
2. Record the exact hardware, driver, filesystem, and workload where it helped.
3. Prefer repeatable before/after measurements over subjective claims alone.
4. Check for regressions, power/thermal costs, and security implications.
5. Make it conditional when the evidence is hardware-specific.
6. Keep it out if the evidence is anecdotal, outdated, or cannot be reproduced.

The `nusa-tune.sh inspect` command collects a read-only snapshot to help determine whether a candidate applies. It does not change system settings.
