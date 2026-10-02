+++
title = "recyclarr"
description = "Sync TRaSH-Guides quality profiles into Sonarr & Radarr daily (bring your own profile YAML)."
[extra]
generated = true
+++

Sync TRaSH-Guides quality profiles into Sonarr & Radarr daily (bring your own profile YAML).

## Enabling it

Importing `nixosModules.recyclarr` enables it; there is no switch.

**Requires:** [arr](@/services/arr.md)

## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `<manual: /var/lib/recyclarr/secrets.yml>` | `sonarr_api_key`, `radarr_api_key` | `recyclarr` | first-boot |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.recyclarr.configFile`

`absolute path` — **required**

Your recyclarr.yml (profiles, custom formats, upgrade policy).

#### `homelab.recyclarr.schedule`

`string` — default `"*-*-* 05:30:00"`

OnCalendar schedule — pick a quiet-disk window (after any parity sync/scrub).

