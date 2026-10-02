+++
title = "The answers file"
description = "Start from a profile, replace the placeholders, choose your modules"
weight = 1
+++

Start from one of the three profiles in the library's `configurator/profiles/` directory. `media-box.json` is the media server with the download stack and parity; `docs-forge.json` is the household office with single sign-on; `everything.json` is every module that needs no manual artifact. Copy one and replace every `REPLACE-…` placeholder: the system disk and data disks by their `/dev/disk/by-id/` names, and your SSH public key.

The file has four parts. `host` names the machine, its time zone, the system disk (erased), the data disks (each becomes one filesystem at `/mnt/disks/<name>`) and your SSH keys. `modules` is the list of library modules to import; the generator adds anything a chosen module `requires`, and the foundation set (`system`, `boot`) is always present. `values` holds `homelab.*` options keyed by their full path: your domain, the admin user, the ACME email, the pool definition, the backup paths. `sops.adminRecipient` is your existing age public key, if you have one; leave it out and the generator makes a key and tells you where to move it.

`homelab-configure schema --modules a,b,c` prints the question set for a module list: every option it reads with type, default and whether it is required, and every secret with its class. If any required option has no value, the generator rejects the answers and lists all of the missing ones at once. The foundation rule applies here: `backup` has to be in the list with `homelab.backup.paths` and `homelab.backup.local.repository` set, or the generator rejects the answers and says why; `monitoring` and `ntfy` are not required, but leaving them out produces a warning.

