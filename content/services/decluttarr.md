+++
title = "decluttarr"
description = "Reap stalled/failed downloads from Sonarr/Radarr and re-search."
[extra]
generated = true
+++

Reap stalled/failed downloads from Sonarr/Radarr and re-search.

Memory: about 64 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.decluttarr` enables it; there is no switch.

**Requires:** [arr](@/services/arr.md)

## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.decluttarr.envFile` | `SONARR_API_KEY`, `RADARR_API_KEY` | `root` | generate |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.decluttarr.envFile`

`string` — **required**

environmentFile with SONARR_API_KEY and RADARR_API_KEY.

