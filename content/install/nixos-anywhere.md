+++
title = "nixos-anywhere"
description = "Boot the target from the NixOS ISO, run one command, wait for the reboot"
weight = 3
+++

At the end of this the target machine will be running your flake, with its disks partitioned, its secrets decrypted, and the one file it wrote itself committed back to your repository. The step erases the disks you named in the answers file.

## Prerequisites

- The generated flake, with the secrets encrypted in it. [Generate](@/install/generate.md) produces it.
- The target machine booted from the installer ISO, or any NixOS ISO.
- Root SSH access to the target, and its address on your network.
- `nixos-anywhere` on the machine you are running from.

## Step 1 — Get root SSH access to the target

At the target's console, give root a password:

```sh
sudo passwd root
```

Then check from the machine you are driving the install from:

```sh
ssh root@<target-ip> true
```

The ISO's documented key method works instead if you would rather not set a password.

## Step 2 — Run nixos-anywhere

From the flake directory, run the command the generator printed:

```sh
nixos-anywhere --flake .#<host> --extra-files ./extra-files \
  --generate-hardware-config nixos-generate-config ./hosts/<host>/hardware.nix \
  root@<target-ip>
```

Five things then happen without further input. It copies the installer closure to the target. It runs disko to partition the system disk and the data disks, erasing them. It writes `hardware.nix` from what it finds in the machine. It runs `nixos-install`. And it copies `extra-files/` into the new root, so the pre-generated SSH host key is in place before anything boots, which is what lets the first activation decrypt your secrets.

Then it reboots the target.

## Step 3 — Commit the file the machine wrote

`hardware.nix` is the one file in the flake that the machine produced rather than you. Commit it:

```sh
git add hosts/<host>/hardware.nix && git commit -m "hardware config from the install"
```

A later reconfigure leaves the real `hardware.nix` alone, so this is the only time you have to think about it.

## Conclusion

The machine is installed and running your configuration. [Day two](@/day-two/_index.md) is the next chapter: the DNS names and the gate, the first logins, and a restore you have run yourself.

The library's own test does exactly this in a virtual machine for each profile: generate, `nixos-anywhere --vm-test`, and a check that the pool mounted after boot. Its first runs found two bugs: an ESP mounted where the boot module did not expect it, and the pool mounting before its member disks.
