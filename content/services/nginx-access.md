+++
title = "nginx-access"
description = "nginx source-access gate: allow/deny inherited by every vhost from one place."
[extra]
generated = true
+++

nginx source-access gate: allow/deny inherited by every vhost from one place.

Memory: about 64 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.nginx-access` enables it; there is no switch.


## Secrets

None.

## Options

This module reads no `homelab.*` options.
