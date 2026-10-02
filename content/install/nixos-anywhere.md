+++
title = "nixos-anywhere"
description = "Boot the target from the NixOS ISO, run one command, wait for the reboot"
weight = 3
+++

Boot the target machine from the NixOS installer ISO and make sure you can SSH to it as root (set a password at the console with `passwd`, or the ISO's documented key method). From the flake directory, the command the generator printed:

```sh
nixos-anywhere --flake .#<host> --extra-files ./extra-files \
  --generate-hardware-config nixos-generate-config ./hosts/<host>/hardware.nix \
  root@<target-ip>
```

It copies the installer closure to the target, runs disko to partition the system disk and the data disks (erasing them), writes `hardware.nix` from what it finds, runs `nixos-install`, and copies `extra-files/` into the new root so the pre-generated SSH host key is in place before the first boot. That key is why the first activation can decrypt your secrets. Then it reboots the target. Commit `hardware.nix` afterwards; it is the one file in the flake the machine wrote.

The library's own test does exactly this in a virtual machine for each profile: generate, `nixos-anywhere --vm-test`, and a check that the pool mounted after boot. Its first runs found two bugs: an ESP mounted where the boot module did not expect it, and the pool mounting before its member disks.

