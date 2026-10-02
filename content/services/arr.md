+++
title = "arr"
description = "Prowlarr + Sonarr + Radarr + Jellyseerr + qBittorrent inside a Gluetun VPN namespace."
[extra]
generated = true
+++

Prowlarr + Sonarr + Radarr + Jellyseerr + qBittorrent inside a Gluetun VPN namespace.

## Enabling it

Importing `nixosModules.arr` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `prowlarr.<homelab.domain>`, `sonarr.<homelab.domain>`, `radarr.<homelab.domain>`, `requests.<homelab.domain>`, `qbittorrent.<homelab.domain>` — create the DNS record.

## Secrets

| Option | File must carry | Read by | Class |
|---|---|---|---|
| `homelab.arrStack.vpnEnvFile` | `WIREGUARD_PRIVATE_KEY`, `WIREGUARD_PRESHARED_KEY`, `WIREGUARD_ADDRESSES`, `SERVER_COUNTRIES`, `FIREWALL_VPN_INPUT_PORTS (optional)` | `root` | supply |

Classes: *generate* — tooling can mint the value; *supply* — only you can provide it; *first-boot* — the value exists only after the service has run once.

## Options

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

`string` — **required**

Host user owning the stack's directories (matches puid).

#### `homelab.arrStack.pgid`

`string` — default `"100"`

gid the stack's containers run as.

#### `homelab.arrStack.puid`

`string` — default `"1000"`

uid the stack's containers run as.

#### `homelab.arrStack.root`

`string` — **required** — example `"/mnt/media/arr"`

The shared /data tree (downloads + media subdirs).

#### `homelab.arrStack.scratchDir`

`null or string` — default `null` — example `"/mnt/scratch/qbittorrent-incomplete"`

Incomplete-download dir on a SEPARATE filesystem (spares the pool's IO; the client copies once on completion). null = incomplete stays inside the /data tree. 

#### `homelab.arrStack.vpnEnvFile`

`string` — **required**

environmentFile with the WireGuard credentials for gluetun (WIREGUARD_PRIVATE_KEY / _PRESHARED_KEY / _ADDRESSES, SERVER_COUNTRIES, optionally FIREWALL_VPN_INPUT_PORTS). Read by docker --env-file as root; root:0400 is fine. 

#### `homelab.arrStack.vpnProvider`

`string` — **required** — example `"mullvad"`

gluetun VPN_SERVICE_PROVIDER for the download client's tunnel.

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

