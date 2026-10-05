+++
title = "The installer ISO"
description = "Download it, write it to a USB stick, boot the box"
weight = 0
+++

The installer is the stock NixOS minimal ISO with `homelab-configure` on it, so the machine you are installing needs no URL and compiles nothing. Download the current image and its checksum:

```sh
curl -fLO https://github.com/ww4/homelab-modules/releases/latest/download/homelab-installer.iso
curl -fLO https://github.com/ww4/homelab-modules/releases/latest/download/homelab-installer.iso.sha256
sha256sum -c homelab-installer.iso.sha256
```

The image is about 1.5 GB. Write it to a USB stick of 4 GB or more with `dd if=homelab-installer.iso of=/dev/sdX bs=4M status=progress` (the stick, not a partition; everything on it is erased) or with Etcher, boot the target from it, and the installer opens by itself on the console (and serves the same wizard at `http://<the machine>:8099`, which is the easier way to fill it in: a browser on your own computer has a clipboard) after it has looked for a newer version of itself on the project's binary cache (so an old stick runs the current installer; `--max-jobs 0` means it downloads or falls back to the copy on the stick, never compiles). `homelab-configure tui` opens it again; Ctrl-Q leaves it and the shell is behind it. Wired network is automatic; for Wi-Fi, `wpa_cli` first. If you would rather use a stock NixOS ISO, `nix run 'github:ww4/homelab-modules?dir=configurator' -- tui` does the same thing after a compile of a few minutes.

Each build is a GitHub release on the library's mirror, tagged `installer-<date>-<commit>` with the image and its checksum attached; the `releases/latest/download/` address above redirects to the newest one, the way distributions publish a current image. The stick looks for a newer installer at boot, so an older image is only stale in its fallback copy.
