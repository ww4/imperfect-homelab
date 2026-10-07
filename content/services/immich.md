+++
title = "immich"
description = "Immich photo & video management."
[extra]
generated = true
+++

Immich photo & video management.

Memory: about 1536 MiB resident at household load (the configurator adds these up against the machine; bursts such as a transcode or an indexing job are extra).

## Enabling it

Importing `nixosModules.immich` enables it; there is no switch.

**Requires:** [acme](@/services/acme.md), [nginx-access](@/services/nginx-access.md)
**Serves:** `photos.<homelab.domain>` — create the DNS record.

## Secrets

None.

## Options

#### `homelab.domain`

`string` — **required** — example `"example.com"`

The base domain every vhost hangs off (services live at &lt;name&gt;.&lt;domain&gt;). No default — set it in your flake. 

#### `homelab.immich.mediaLocation`

`string` — default `"/mnt/media/immich"` — example `"/mnt/media/immich"`

Where Immich stores photo/video data.

#### `homelab.immich.mlUrl`

`null or string` — default `null` — example `"http://ml-host:3003"`

Remote immich machine-learning endpoint; null = local ML.

