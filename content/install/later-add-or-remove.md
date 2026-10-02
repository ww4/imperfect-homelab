+++
title = "Later: add or remove a module"
description = "generate again on the same directory"
weight = 4
+++

Run `generate` again on the same directory with `--add paperless`, `--remove glances`, or `--set homelab.backup.keep.daily=14`, and it starts from the recorded answers. It keeps existing secrets rather than minting them again; your keys and console password stay; it leaves the real `hardware.nix` alone. `FIRST-LOGIN.md` appears only when a newly added module minted something. The next step it prints is a rebuild.

The run checks removals. A module another chosen module requires stays, and the run says so. It refuses to remove the foundation modules. A removed service's state under `/var/lib` and its secret file stay where they are until you delete them, which the run also says.

