+++
title = "nginx-log-paths-check"
description = "Build-time guard: nginx may only be told to write logs where it can write."
[extra]
generated = true
+++

Build-time guard: nginx may only be told to write logs where it can write.

Memory: about 8 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.nginx-log-paths-check` enables it; there is no switch.


## Secrets

None.

## Options

This module reads no `homelab.*` options.
