+++
title = "remote-desktop"
description = "xrdp + XFCE remote desktop, Tailscale-only."
[extra]
generated = true
+++

xrdp + XFCE remote desktop, Tailscale-only.

Memory: about 256 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.remote-desktop` enables it; there is no switch.


## Secrets

None.

## Options

This module reads no `homelab.*` options.
