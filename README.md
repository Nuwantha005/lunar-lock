# lunar-lock

> [!NOTE]
> This repository is a custom fork of [Darkkal44/qylock](https://github.com/Darkkal44/qylock). It provides the lock screen theme suite integrated directly into [lunar-shell](https://github.com/Nuwantha005/lunar-shell) via [lunar-cli](https://github.com/Nuwantha005/lunar-cli).

---

## Reasoning for Forking & Modifications

The original `qylock` repository was adapted to create `lunar-lock` to integrate lock screen themes natively into Wayland desktop sessions:
- **Native Wayland Session Integration**: Adapted standalone Qylock themes to render within `lunar-shell`'s `WlSessionLock` protocol using `lunar-shell`'s native PAM authentication module.
- **Dual Compatibility**: Retained the original SDDM installation scripts (`sddm.sh`), enabling themes to function both as SDDM login screens and as integrated desktop session lock screens.
- **Custom Background Injection (`custom-qylock`)**: Extended themes to support custom image and video (`.mp4`, `.webm`, `.mkv`) background overrides, including modifying themes that originally lacked video support.

---

## Features

- **Rich Theme Collection**: Complete collection of SDDM / Quickshell lock screen themes adapted for Wayland session locking.
- **Dual SDDM & Session Lock Support**: Works out of the box with SDDM using original setup scripts (`sddm.sh`), or as an integrated component inside `lunar-shell`.
- **Dynamic Background Injection**: Support for custom image and live video backgrounds on compatible themes (`custom-qylock` backend).

---

## Technical Details

### Deep Integration Mechanics

Rather than launching a separate QuickShell process (`quickshell.sh` / `lock_shell.qml`) which conflicts with running desktop shells, `lunar-shell` connects `lunar-lock` via a local relative symlink:

`lunar-shell/lock-themes` → `../lunar-lock/themes/`

`lunar-shell`'s `QylockSurface.qml` dynamically imports the selected Qylock theme (`Main.qml`) inside its existing `WlSessionLock` container and binds input events to `lunar-shell`'s PAM authentication service (`Pam.qml`).

### Custom Background Injection Logic

When running under the `custom-qylock` backend:
1. `lunar-shell` checks `~/.local/state/caelestia/lock_override_bg` for an active background override.
2. If set, `QylockSurface.qml` injects an underlying image or QML `MediaPlayer` surface behind the theme components, replacing default theme static assets.

---

## Installation & Setup

> [!WARNING]
> Installation currently requires manual configuration and technical knowledge, as file paths are hardcoded across `lunar-shell`, `lunar-cli`, and `lunar-lock`. A unified installation script is planned as a future target.

### Standalone SDDM Setup
For standalone SDDM login screen usage, run the included script:
```sh
chmod +x sddm.sh && ./sddm.sh
```

---

## Known Issues & Limitations

- **Custom Background Incompatibilities**: Certain Qylock themes use internal QML structures or hardcoded background layers that do not respect custom background overrides:
  - *Blur plane only*: `genshin`, `clockwork`
  - *Default background fallback*: `R1999_1`, `girl-coffee`, `last-of-us`, `nothing`, `star-rail`, `wuwa`
- **Unlocking Behavior**: A subset of themes (e.g. `material-you`, `ninesols`, `ninja_gaiden`, `nothing`, `osu`, `osumania`) fail to trigger session unlocking when pressing `Enter`. This is an upstream QML interaction issue present in the original themes.
- **Preview Thumbnail Resolution**: Upstream `.gif` previews provided by theme creators are low resolution/blurry. Piping high-res live frames directly from the headless compositor (starting with vanilla Qylock) is planned for future iterations.

---

## Gallery

<!-- Add screenshots and videos here -->
