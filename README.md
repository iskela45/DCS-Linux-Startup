# DCS on Linux — Startup Scripts

Personal collection of scripts for launching a DCS World sim setup on Linux. Shared as a reference — paths are hardcoded to my filesystem and will need adjusting if you adapt these for your own setup.

## What's here

| Script | Purpose |
|--------|---------|
| `simstart.sh` | Master startup script — runs everything below in order |
| `winwing-start.sh` | Starts the Windows VM and attaches WinWing USB devices via libvirt |
| `winwing-receiver.sh` | Starts the uinput virtual device receiver |
| `linuxtrack.sh` | Starts LinuxTrack for head tracking |
| `telemffb.sh` | Starts VPforce TelemFFB for force feedback |
| `mfd-display.sh` | Enables/disables the MFD monitor via kscreen-doctor |
| `dcs.sh` | Launches DCS World via Lutris |
| `update-quaggles-injector.sh` | Checks and updates the Quaggles DCS Input Command Injector mod |
| `remap_pov.sh` | Remaps POV hat inputs to button equivalents in DCS `.diff.lua` files |

## Dependencies

These repos are required and their paths must be set correctly in the scripts:

- [SimAppPro-on-Linux-input-transmitter](https://github.com/iskela45/SimAppPro-on-Linux-input-transmitter) — WinWing input forwarding from Windows VM to Linux uinput devices. Path configured via `WINWING_DIR` in `simstart.sh`.
- [VPforce-TelemFFB](https://github.com/iskela45/VPforce-TelemFFB) — Force feedback telemetry for VPforce Rhino, personal fork to make the software run on Linux. Path hardcoded in `telemffb.sh`.
- [DCS-on-Linux](https://github.com/ChaosRifle/DCS-on-Linux) — DCS World launcher and tooling for Linux. Path hardcoded in `simstart.sh` and `dcs.sh`.

## Adapting for your own setup

Several scripts have hardcoded absolute paths that will need updating:

- `simstart.sh` — `SCRIPT_DIR`, `WINWING_DIR`
- `telemffb.sh` — path to `VPforce-TelemFFB/run.sh`
- `linuxtrack.sh` — path to the `ltr_gui` binary
- `update-quaggles-injector.sh` — `STAGING_DIR`, `TMP_DIR`
