+++
title = "The installer ISO"
description = "Download it, check it, write it to a USB stick, boot the box"
weight = 0
+++

At the end of this you will have the target machine booted into the installer with `homelab-configure` on its path. The image is the stock NixOS minimal ISO with the configurator added, so the machine you are installing needs no URL typed into it and compiles nothing.

## Prerequisites

- A Linux or macOS machine with `curl` and `dd`, or Windows with Rufus. The [Quick start](@/quick-start/make-the-stick.md) has the Rufus clicks.
- A USB stick of 4 GB or more. Writing erases it.
- The target machine, with a wired network connection.

## Step 1 — Download the image and its checksum

```sh
curl -fLO https://github.com/ww4/homelab-modules/releases/latest/download/homelab-installer.iso
curl -fLO https://github.com/ww4/homelab-modules/releases/latest/download/homelab-installer.iso.sha256
```

The image is about 1.5 GB. That `releases/latest/download/` address redirects to the newest build, the way distributions publish a current image.

## Step 2 — Check the download

```sh
sha256sum -c homelab-installer.iso.sha256
```

It should print `homelab-installer.iso: OK`. Anything else means the download is incomplete, and writing it to a stick wastes the next ten minutes.

## Step 3 — Write it to a USB stick

Point `dd` at the stick, not at a partition on it. Everything on the stick is erased.

```sh
sudo dd if=homelab-installer.iso of=/dev/sdX bs=4M status=progress conv=fsync
```

Etcher does the same thing with a file picker if you would rather not name a device by hand.

## Step 4 — Boot the target and open the wizard

Boot the target machine from the stick. The installer opens by itself on the console after it has looked for a newer version of itself on the project's binary cache, so an old stick runs the current installer. That lookup passes `--max-jobs 0`, which means it downloads a newer configurator or falls back to the copy on the stick, and never compiles one.

The same wizard is served at `http://<the machine>:8099`, which is the easier way to fill it in, because a browser on your own computer has a clipboard. The console prints the address and the code that gates it.

`homelab-configure tui` opens the console wizard again if you close it, and Ctrl-Q leaves it with a shell behind. A wired network is automatic; for Wi-Fi, run `wpa_cli` first.

## Conclusion

The machine is sitting in the installer and nothing has been written to its disks. [The answers file](@/install/the-answers-file.md) is the next step if you are driving the configurator from a file rather than filling in the wizard.

If you would rather not use this image at all, a stock NixOS ISO plus `nix run 'github:ww4/homelab-modules?dir=configurator' -- tui` does the same thing after a compile of a few minutes. Each image is a release on the library's GitHub mirror, tagged `installer-<date>-<commit>` with the image and its checksum attached, so an older tag is still downloadable if you need the exact build you installed from.
