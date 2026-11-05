# Nusa Tune: FreeBSD desktop tuning guide

Nusa Tune is a general guide to making FreeBSD desktops responsive, reliable, and comfortable across supported hardware. It is not tied to one computer, virtual machine, graphics card, desktop environment, or workload.

The goal is not to maximize benchmark numbers by collecting sysctl values. Start with a sound FreeBSD installation, working device drivers, and the desktop's native settings. Add system-level tuning only when it addresses a real limitation and has evidence behind it.

## General baseline

- Keep FreeBSD, packages, and firmware aligned with a supported release and a coherent package repository.
- Use the correct graphics driver for the GPU. Driver support and acceleration matter more than speculative kernel flags.
- Keep the default scheduler, virtual-memory behavior, and network processing settings unless measurements identify a bottleneck.
- Use the desktop environment's own controls for compositor effects, animation, scaling, and application startup.
- Enable only services the machine actually needs.
- Measure the workload before and after a change. Responsiveness, frame pacing, audio dropouts, battery life, and thermal behavior can matter more than peak throughput.

FreeBSD already manages many scheduler, memory, and device behaviors dynamically. There is no defensible universal list of sysctl values that makes every FreeBSD desktop faster.

## Tuning areas

### CPU scheduling and responsiveness

FreeBSD's scheduler is designed to balance interactive and throughput workloads. Leave scheduler tunables at their defaults unless a repeatable test demonstrates a specific problem. Old desktop-tuning posts often carry values or OID names from earlier FreeBSD releases; do not copy them without checking the current release's manual pages and defaults.

### CPU frequency and power

CPU frequency policy is platform- and driver-dependent. FreeBSD supports several frequency-control mechanisms, including `cpufreq`, `est`, and `hwpstate_intel`. Tools such as `powerd` or `powerdxx` are not interchangeable with every driver; the Handbook notes that Intel Speed Shift systems using `hwpstate_intel` are handled differently.

Treat power policy as a choice between responsiveness, heat, noise, and battery life—not as a universal performance switch. Verify the active driver and supported controls before changing anything.

### Graphics and display

Prioritize a supported driver and working hardware acceleration. Intel, AMD, and NVIDIA use different driver paths; a setting documented for one driver must not be applied to another. Hybrid graphics, external displays, suspend/resume, and Wayland support should be validated independently.

The FreeBSD Handbook documents Intel LinuxKPI graphics power options for systems using the relevant Intel DRM driver. They are not general graphics tunables.

### Memory and storage

Do not impose generic ZFS ARC limits or VM tunables on all desktops. Filesystem, RAM size, workload, and actual memory pressure matter. FreeBSD's VM system already adapts many behaviors; change limits only when measurements show a real memory-pressure problem.

### Networking

Keep the default network stack settings unless packet-processing measurements identify a bottleneck. Reports about `net.isr` settings are workload- and hardware-specific and are not enough to justify global defaults.

### Audio and multimedia

Confirm the intended audio device and use the desktop's mixer controls. Device enumeration can make HDMI/DisplayPort audio appear before onboard analog audio; selecting the correct default device is a configuration fix, not a performance tweak. For real-time audio work, evaluate latency and xruns with the actual interface and application rather than applying unrelated kernel recipes.

### Desktop environment

Tune the desktop at the desktop layer first: compositor settings, animation, startup applications, indexing, power profiles, and display scaling. KDE, GNOME, XFCE, and other environments have different controls. A setting that improves one compositor or display server may be irrelevant or harmful in another.

## Hardware-specific options

Some optimizations are valid only for a specific driver, CPU feature, filesystem, or device. Keep these as clearly labeled optional guidance, state the prerequisite, and link to the authoritative documentation. Never make them global defaults.

Examples:

- Intel DRM power options apply only to the documented Intel graphics driver path.
- CPU frequency tools depend on the active frequency driver and CPU capabilities.
- GPU-specific settings must match the installed driver and supported hardware.
- ZFS memory limits should be considered only with evidence of memory pressure and an understanding of the workload.

## Reviewed tuning candidates

| Candidate | General recommendation |
|---|---|
| Scheduler tunables such as `kern.sched.ule.*` | Keep defaults; require a reproducible workload-specific result. |
| `powerd` / `powerdxx` | Conditional; verify the CPU frequency driver and supported mechanism first. |
| Intel `compat.linuxkpi.*` graphics options | Conditional; Intel DRM driver only, following current Handbook guidance. |
| `net.isr.*` | Keep defaults absent a measured network-processing bottleneck. |
| ZFS ARC limits | Keep defaults absent measured memory pressure and workload-specific evidence. |
| `kern.ipc.shm_allow_removed` | Compatibility setting only when an application requires it; not a speed tweak. |

## Rules for adding a recommendation

1. Confirm the setting exists and verify its meaning and default on supported FreeBSD releases.
2. Identify the prerequisite hardware, driver, filesystem, or workload.
3. Prefer official documentation and reproducible measurements over copied configuration snippets.
4. Record both the benefit and any cost: regressions, power use, heat, stability, or security.
5. Keep conditional changes opt-in and explain how to reverse them.
6. If the evidence is weak or narrowly anecdotal, document it as an experiment—or leave it out.

## References

- [FreeBSD Handbook: Configuration, Services, Logging and Power Management](https://docs.freebsd.org/en/books/handbook/config/) — CPU frequency control, power management, and driver-specific graphics options.
- [FreeBSD Handbook: Desktop Environments](https://docs.freebsd.org/en/books/handbook/desktop/) — supported desktop environments and their setup.
- [FreeBSD Handbook: X Window System](https://docs.freebsd.org/en/books/handbook/x11/) — graphics drivers and display configuration.
- [FreeBSD Handbook: Multimedia](https://docs.freebsd.org/en/books/handbook/multimedia/) — audio devices and multimedia configuration.
- [FreeBSD Architecture Handbook: Virtual Memory](https://docs.freebsd.org/en/books/arch-handbook/vm/) — FreeBSD memory management.
- [FreeBSD tuning(7)](https://man.freebsd.org/cgi/man.cgi?query=tuning) — official performance-tuning guidance.
