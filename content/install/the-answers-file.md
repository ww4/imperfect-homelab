+++
title = "The answers file"
description = "Start from a profile, replace the placeholders, choose your modules, check the question set"
weight = 1
+++

At the end of this you will have one JSON file that describes the machine you want, which is everything `generate` needs apart from the secrets. The wizard writes the same file for you; doing it by hand is the path to take when you are installing several machines, or driving the configurator from a script.

## Prerequisites

- A checkout of the library, or the configurator available through `nix run`.
- The `/dev/disk/by-id/` names of the disks in the target machine. Run `ls -l /dev/disk/by-id/` on the booted installer to get them.
- Your SSH public key.
- Your domain name.

## Step 1 — Copy a profile

Three profiles live in the library's `configurator/profiles/` directory:

| Profile | What it is |
|---|---|
| `media-box.json` | the media server with the download stack and parity |
| `docs-forge.json` | the household office with single sign-on |
| `everything.json` | every module that needs no manual artifact |

Copy the nearest one to `my.json` and edit that. Starting from a profile means the module list is already consistent, which is most of the work.

## Step 2 — Replace every placeholder

Search the file for `REPLACE-` and replace each one. There are three kinds:

- The system disk and the data disks, by their `/dev/disk/by-id/` names. The system disk is erased. Each data disk becomes one filesystem at `/mnt/disks/<name>`.
- Your SSH public key.
- Your domain.

Nothing checks for a leftover `REPLACE-` by name, so read the file once more when you think you are done.

## Step 3 — Understand the four parts

The file has four top-level keys, and knowing which one a value belongs in saves a round trip through the error messages.

`host` names the machine, its time zone, the system disk, the data disks and your SSH keys.

`modules` is the list of library modules to import. The generator adds anything a chosen module `requires`, and the foundation set (`system` and `boot`) is always present whether you list it or not.

`values` holds `homelab.*` options keyed by their full path: your domain, the admin user, the ACME email, the pool definition, the backup paths.

`sops.adminRecipient` is your existing age public key. Leave it out and the generator makes a key and tells you where to move it.

## Step 4 — Check the question set before you generate

`schema` prints every option a module list reads, with its type, its default, and whether it is required, plus every secret with its class:

```sh
homelab-configure schema --modules jellyfin,tandoor,backup,monitoring
```

Add `--json` to get the same thing machine-readably. Reading this before you run `generate` is faster than discovering a missing value afterwards, though the generator does list every problem at once rather than stopping at the first.

## Step 5 — Satisfy the foundation rules

Two rules reject an answers file, and both have the same shape: something has to be present before the first install, because adding it later is harder than adding it now.

`backup` has to be in the module list, with `homelab.backup.paths` and `homelab.backup.local.repository` set. The restore path has to exist before there is anything to restore.

`monitoring` and `ntfy` are not required, and leaving them out produces a warning instead of a rejection. A machine with no monitoring fails without telling you.

## Conclusion

You have an answers file that describes the machine. Next, [Generate](@/install/generate.md) turns it into a flake you own, mints the secrets it can, and asks for the ones only you have.
