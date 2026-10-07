+++
title = "unpackerr"
description = "Extract RAR'd releases in place so the *arrs can import them; seeds untouched."
[extra]
generated = true
+++

Extract RAR'd releases in place so the *arrs can import them; seeds untouched.

Memory: about 48 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.unpackerr` enables it; there is no switch.

**Requires:** [arr](@/services/arr.md)

## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.unpackerr.envFile` | `UN_SONARR_0_API_KEY`, `UN_RADARR_0_API_KEY` | `root` | generate |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

#### `homelab.arrStack.apiKeyEnvFile`

`null or string` — default `null` — example `"/run/secrets/arr-api-keys"`

Env file with SONARR_API_KEY / RADARR_API_KEY / PROWLARR_API_KEY (and LIDARR_API_KEY if lidarr is imported). When set, each app is seeded with its key before first start, so the keys are values the configuration owns rather than something copied out of a UI, and recyclarr renders its secrets from the same file. Read as root; root:0400 is fine. null = each *arr mints its own key on first run. 

#### `homelab.arrStack.group`

`string` — default `"users"`

Host group owning the stack's directories (matches pgid).

#### `homelab.arrStack.keepersMovies`

`null or string` — default `null`

Optional long-term-keeper library mounted at /keepers/movies — add it as a second Radarr root folder and promote via Edit → Root Folder; the *arr moves the file + updates its DB. 

#### `homelab.arrStack.keepersTv`

`null or string` — default `null`

Optional keeper library mounted at /keepers/tv (Sonarr twin of keepersMovies).

#### `homelab.arrStack.owner`

`string` — default `"admin"`

Host user owning the stack's directories (matches puid). Defaults to homelab.adminUser: the account a fresh install is sure to have.

#### `homelab.arrStack.pgid`

`string` — default `"100"`

gid the stack's containers run as.

#### `homelab.arrStack.puid`

`string` — default `"1000"`

uid the stack's containers run as.

#### `homelab.arrStack.root`

`string` — default `"/mnt/media/arr"` — example `"/mnt/media/arr"`

The shared /data tree (downloads + media subdirs). The default sits on the media pool, which is where a disk marked `data` at install is mounted.

#### `homelab.arrStack.scratchDir`

`null or string` — default `null` — example `"/mnt/scratch/qbittorrent-incomplete"`

Incomplete-download dir on a SEPARATE filesystem (spares the pool's IO; the client copies once on completion). null = incomplete stays inside the /data tree. 

#### `homelab.arrStack.vpnEnvFile`

`string` — **required**

environmentFile with the WireGuard credentials for gluetun (WIREGUARD_PRIVATE_KEY / _PRESHARED_KEY / _ADDRESSES, SERVER_COUNTRIES, optionally FIREWALL_VPN_INPUT_PORTS). Read by docker --env-file as root; root:0400 is fine. 

#### `homelab.arrStack.vpnProvider`

`string` — **required** — example `"mullvad"`

gluetun VPN_SERVICE_PROVIDER for the download client's tunnel.

#### `homelab.unpackerr.envFile`

`string` — **required**

environmentFile with UN_SONARR_0_API_KEY and UN_RADARR_0_API_KEY.

