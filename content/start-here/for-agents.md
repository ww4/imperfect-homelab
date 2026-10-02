+++
title = "For agents"
description = "The headless contract, for an AI agent driving the install on someone's behalf"
weight = 4
+++

If you are an AI agent and someone has handed you this site, the short version is in two files: {{ link(path="llms.txt", text="llms.txt") }} says what is where, and {{ link(path="skills/homelab-install/SKILL.md", text="the install skill") }} is the procedure. This page is the contract behind both, written for a reader who will act on it.

The configurator is headless first. `homelab-configure` takes an answers file and writes a private NixOS flake; the terminal UI is a front end that produces the same file and calls the same command. Every command takes `--json`. `schema --json` returns the whole question set: each module, the options it reads with type, default and whether it is required, and each secret with its class. `generate` returns exit 0 with a report, exit 2 with every problem it found at once (a missing value, a secret not supplied, a foundation module absent, a removal it refused), or exit 3 when the result failed to evaluate. Nothing is installed by any of this; the output is a directory.

Three things the tool enforces so that you do not have to remember them. Secrets never enter the answers file: supplied ones arrive as a file path or an environment variable, generated ones are minted and encrypted, and the show-once values go to a file the user reads and deletes. The foundation set is checked on every run: `system` and `boot` are added, `backup` must be present and configured before the first install, and `mergerfs-pools` and `backup` cannot be removed later; a removal that another module requires is refused with the dependent named. And the disk the live system booted from is never offered by the picker; when you choose disks yourself, use `/dev/disk/by-id/` names and leave that one alone.

Two things are yours alone. Never ask the user to paste a secret to you; ask them to put it in a file, and tell them which variable names it must carry (the schema says). And never run `install` on your own authority: it erases the named disks, and the typed confirmation of the host name is there so that a person says yes to the exact device list. If the user wants you to run it unattended, they say so, and you pass `--yes`.

The box itself is easy to reach. The installer ISO runs sshd; the user sets a password at the console with `passwd` and gives you the address, and `ssh nixos@<address>` lands you on a machine where `homelab-configure` is on the path and `sudo` needs no password. From there the skill's procedure applies as written. If the user is installing a different machine from where you run, generate locally and hand off to `nixos-anywhere` as the generated README says.

Everything on this site is also in {{ link(path="llms-full.txt", text="llms-full.txt") }} as one plain-text file, regenerated from the same source as the pages, so you can read the whole guide in one fetch.
