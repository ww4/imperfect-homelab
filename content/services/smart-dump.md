+++
title = "smart-dump"
description = "Dump the full SMART table for every drive to world-readable files."
[extra]
generated = true
+++

Dump the full SMART table for every drive to world-readable files.

Memory: about 8 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.smart-dump` enables it; there is no switch.


## Secrets

None.

## Options

This module reads no `homelab.*` options.
