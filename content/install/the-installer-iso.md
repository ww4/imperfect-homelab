+++
title = "The installer ISO"
description = "Download it, write it to a USB stick, boot the box"
weight = 0
+++

The installer is the stock NixOS minimal ISO with `homelab-configure` on it, so the machine you are installing needs no URL and compiles nothing. Download the current image and its checksum:

```sh
base=https://homelab-installer.nyc3.cdn.digitaloceanspaces.com/iso
name=$(curl -fsSL $base/latest.txt)
curl -fLO $base/$name && curl -fLO $base/$name.sha256
sha256sum -c $name.sha256
```

The newest image is also always at `$base/homelab-installer-latest.iso` (the same bytes under a fixed name, with its `.sha256` beside it), which is what the [Quick start](@/quick-start/_index.md) links. The image is about 1.5 GB. Write it to a USB stick of 4 GB or more with `dd if=$name of=/dev/sdX bs=4M status=progress` (the stick, not a partition; everything on it is erased) or with Etcher, boot the target from it, and the console prints the two commands to type. Wired network is automatic; for Wi-Fi, `wpa_cli` first. If you would rather use a stock NixOS ISO, `nix run 'github:ww4/homelab-modules?dir=configurator' -- tui` does the same thing after a compile of a few minutes.

Each release of the image is named by date and library commit; `latest.txt` always names the newest, and the chapter's commands follow it.
